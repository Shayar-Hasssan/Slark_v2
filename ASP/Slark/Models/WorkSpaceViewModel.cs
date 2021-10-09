using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Slark.Models
{

    public class RegisterViewModels
    {
        public string Email { get; set; }
        public string Password { get; set; }
        public string Name { get; set; }


    }
  
    public class LoginViewModels
    {
        public string Email { get; set; }
        public string Password { get; set; }
    }

    public class WorkSpaceViewModel
    {
        public string Id { get; set; }
        public string WsName { get; set; }
        public bool Ismine { get; set; }

    }
    public class SpaceViewModel
    {
        public string Id { get; set; }
        public string Name { get; set; }

    }
}