using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace AlphaClient.Settings
{
    public class Server : ConfigurationElement
    {
        [ConfigurationProperty("ipAddr", IsRequired = true)]
        public String  IPAddr
        {
            get
            {
                return this["ipAddr"] as string;
            }
        }

        [ConfigurationProperty("name", IsRequired = true)]
        public String Name
        {
            get
            {
                return this["name"] as string;
            }
        }
    }
}
