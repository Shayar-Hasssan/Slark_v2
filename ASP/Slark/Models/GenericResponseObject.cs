using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace Slark.Models
{
    public class GenericResponseObject<T>
    {
        public List<T> data { get; set; }
        public string message { get; set; }
        public int Code { get; set; }

    }
  

}
