//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Slark.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class ChatRoom
    {
        public string Id { get; set; }
        public string ProjectId { get; set; }
        public string ChatContent { get; set; }
        public string SenderId { get; set; }
        public System.DateTime CreationDate { get; set; }
    
        public virtual AspNetUser AspNetUser { get; set; }
        public virtual Project Project { get; set; }
    }
}