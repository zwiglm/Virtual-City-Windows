using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AlphaClient.Settings
{
    public class Servers : ConfigurationElementCollection
    {
        public Server this[int index]
        {
            get
            {
                return base.BaseGet(index) as Server;
            }
            set
            {
                if (base.BaseGet(index) != null) {
                    base.BaseRemoveAt(index);
                }
                this.BaseAdd(index, value);
            }
        }

        public new Server this[string responseString]
        {
            get { return (Server)BaseGet(responseString); }
            set
            {
                if (BaseGet(responseString) != null) {
                    BaseRemoveAt(BaseIndexOf(BaseGet(responseString)));
                }
                BaseAdd(value);
            }
        }

        protected override ConfigurationElement CreateNewElement()
        {
            return new Server();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            return ((Server)element).Name;
        }
    }
}
