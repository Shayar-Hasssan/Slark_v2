using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Slark.Startup))]
namespace Slark
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
