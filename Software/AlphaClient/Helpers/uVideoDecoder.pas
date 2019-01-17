unit uVideoDecoder;

interface

uses

    Winapi.Windows, System.SysUtils, Vcl.ExtCtrls, Vcl.Graphics,
    iVideoDecoder,
    uGlobalConsts, uPictureContainer,
    FFUtils,
    libavcodec,
    libavcodec_avfft,
    libavdevice,
    libavfilter,
    libavfilter_avcodec,
    libavfilter_buffersink,
    libavfilter_buffersrc,
    libavfilter_formats,
    libavformat,
    libavformat_avio,
    libavformat_url,
    libavutil,
    libavutil_audio_fifo,
    libavutil_avstring,
    libavutil_bprint,
    libavutil_buffer,
    libavutil_channel_layout,
    libavutil_common,
    libavutil_cpu,
    libavutil_dict,
    libavutil_display,
    libavutil_error,
    libavutil_eval,
    libavutil_fifo,
    libavutil_file,
    libavutil_frame,
    libavutil_imgutils,
    libavutil_log,
    libavutil_mathematics,
    libavutil_md5,
    libavutil_mem,
    libavutil_motion_vector,
    libavutil_opt,
    libavutil_parseutils,
    libavutil_pixdesc,
    libavutil_pixfmt,
    libavutil_rational,
    libavutil_samplefmt,
    libavutil_time,
    libavutil_timestamp,
    libswresample,
    libswscale;

const
  INBUF_SIZE = 4096;

type

    TVideoDecoder = class(TInterfacedObject, TIVideoDecoder)
    var
        // TImage -> TPicture -> TBitmap -> Bitmap
        _currImage : TImage;
    private
        procedure createAvBuffer(source: array of Byte; out destination: array of Byte);
        function decodeFrame(dec_ctx: PAVCodecContext; out frame: PAVFrame; pkt: PAVPacket) : Boolean;
    public
        function DecodeBytes(encodedContent: array of byte; dataSize: LongInt) : Integer;
    end;



implementation

    function TVideoDecoder.DecodeBytes(encodedContent: array of byte; dataSize: LongInt) : Integer;
    var
        codec: PAVCodec;
        parser: PAVCodecParserContext;
        c: PAVCodecContext;
        f: THandle;
        frame: PAVFrame;
//        inbuf: array[0..INBUF_SIZE + AV_INPUT_BUFFER_PADDING_SIZE - 1] of Byte;
        inbuf: array of Byte;
        data: PByte;
        data_size: Cardinal;
        ret: Integer;
        pkt: PAVPacket;
    begin
        avcodec_register_all();

        pkt := av_packet_alloc();
        if not Assigned(pkt) then
        begin
            Result := TGlobalConsts.AV_PACKET_ALLOC_ERR;
            Exit;
        end;

        (* set end of buffer to 0 (this ensures that no overreading happens for damaged MPEG streams) *)
        SetLength(inbuf, dataSize + AV_INPUT_BUFFER_PADDING_SIZE);
        FillChar(inbuf[INBUF_SIZE], AV_INPUT_BUFFER_PADDING_SIZE, 0);

        (* find the MPEG1 video decoder *)
//        codec := avcodec_find_decoder(AV_CODEC_ID_MPEG1VIDEO);
        codec := avcodec_find_decoder(AV_CODEC_ID_INDEO5);
        if not Assigned(codec) then
        begin
            Result := TGlobalConsts.AV_FIND_DECODER_ERR;
            Exit;
        end;

        c := avcodec_alloc_context3(codec);
        if not Assigned(c) then
        begin
            Result := TGlobalConsts.AV_CONTEXT_ALLOC_ERR;
            Exit;
        end;

      (* For some codecs, such as msmpeg4 and mpeg4, width and height
         MUST be initialized there because this information is not
         available in the bitstream. *)

      (* open it *)
        if avcodec_open2(c, codec, nil) < 0 then
        begin
            Result := TGlobalConsts.AV_OPEN_CODEC_ERR;
            Exit;
        end;

        frame := av_frame_alloc();
        if not Assigned(frame) then
        begin
            Result := TGlobalConsts.AV_FRAME_ALLOC_ERR;
            Exit;
        end;

        while True do // not feof(f)
        begin
          (* read raw data from the input file *)
          createAvBuffer(encodedContent, inbuf);
          data_size := dataSize;

          (* use the parser to split the data into frames *)
          data := @inbuf[0];
          while data_size > 0 do
          begin
            ret := av_parser_parse2(parser, c, @pkt.data, @pkt.size, data, data_size, AV_NOPTS_VALUE, AV_NOPTS_VALUE, 0);
            if ret < 0 then
            begin
              Result := 1;
              Exit;
            end;
            Inc(data, ret);
            Dec(data_size, ret);

            if pkt.size <> 0 then
              if Not decodeFrame(c, frame, pkt) then
              begin
                Result := 1;
                Exit;
              end;
          end;
        end;
        Result := TGlobalConsts.NO_ERROR;

        (* flush the decoder *)
        if Not decodeFrame(c, frame, nil) then
          Result := 1;

        av_parser_close(parser);
        avcodec_free_context(@c);
        av_frame_free(@frame);
        av_packet_free(@pkt);
    end;


    function TVideoDecoder.decodeFrame(dec_ctx: PAVCodecContext; out frame: PAVFrame; pkt: PAVPacket) : Boolean;
    var
      ret: Integer;
    begin
      ret := avcodec_send_packet(dec_ctx, pkt);
      if ret < 0 then
      begin
//        Writeln(ErrOutput, 'Error sending a packet for decoding');
        Result := False;
        Exit;
      end;

      while ret >= 0 do
      begin
        ret := avcodec_receive_frame(dec_ctx, frame);
        if (ret = AVERROR_EAGAIN) or (ret = AVERROR_EOF) then
        begin
          Result := True;
          Exit;
        end
        else if ret < 0 then
            begin
//              Writeln(ErrOutput, 'Error during decoding');
              Result := False;
              Exit;
            end;

//        Writeln(Format('saving frame %3d', [dec_ctx.frame_number]));
        //fflush(stdout);

        (* the picture is allocated by the decoder, no need to free it *)
      end;

      Result := True;
    end;

    procedure TVideoDecoder.createAvBuffer(source: array of Byte; out destination: array of Byte);
    var
        I: LongInt;
    begin
        for I := 0 to SizeOf(source) - 1 do
        begin
            destination[I] := source[I];
        end;
    end;

end.
