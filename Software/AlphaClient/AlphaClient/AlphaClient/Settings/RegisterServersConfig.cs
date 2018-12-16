using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AlphaClient.Settings
{
    public class RegisterServersConfig : ConfigurationSection
    {

        public static RegisterServersConfig GetConfig()
        {
            return (RegisterServersConfig)System.Configuration.ConfigurationManager.GetSection("RegisterServers") ?? new RegisterServersConfig();
        }

        [System.Configuration.ConfigurationProperty("Servers")]
        [ConfigurationCollection(typeof(Servers), AddItemName = "Server")]
        public Servers Servers
        {
            get
            {
                object o = this["Servers"];
                return o as Servers;
            }
        }

    }
}
