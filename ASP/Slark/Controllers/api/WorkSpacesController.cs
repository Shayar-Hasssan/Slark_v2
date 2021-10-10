using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using System.Web.Http.Description;
using Microsoft.AspNet.Identity.Owin;
using Slark.Models;
using Microsoft.AspNet.Identity;
using Task = System.Threading.Tasks.Task;
using System;
using System.Collections.Generic;

namespace Slark.Controllers
{
    public class WorkSpacesController : ApiController
    {
        private SlarkEntities db = new SlarkEntities();

        private ApplicationSignInManager _signInManager;
        private ApplicationUserManager _userManager;

        [Route("api/register")]
        [HttpPost]
        public List<WorkSpaceViewModel> regiesterCustomerAsync([FromBody] RegisterViewModels body)
        {

            RegisterViewModel model = new RegisterViewModel();
            model.Email = body.Email;
            model.Password = body.Password;
            var user = new ApplicationUser { UserName = model.Email, Email = model.Email };
            var result = UserManager.Create(user, model.Password);
            if (result.Succeeded)
            {
                 var currentUser = UserManager.FindByName(user.UserName);
                    var newuser = db.AspNetUsers.Find(currentUser.Id);
                    newuser.Name = body.Name;
                    db.Entry(newuser).State = EntityState.Modified;
                    db.SaveChanges();
                WorkSpace ws = new WorkSpace();
                ws.Id = Guid.NewGuid().ToString();
                ws.WsName = body.Name;
                db.WorkSpaces.Add(ws);
                db.SaveChanges();
                WsManager wsm = new WsManager();
                wsm.Id = Guid.NewGuid().ToString();
                wsm.UserId = currentUser.Id;
                wsm.WSId = ws.Id;
                db.WsManagers.Add(wsm);
                db.SaveChanges();

                List<WorkSpace> lws = new List<WorkSpace>();
                List<WorkSpaceViewModel> wsViewmodel = new List<WorkSpaceViewModel>();
                var a = db.WsManagers.Where(x => x.UserId == currentUser.Id).Select(z=>z.WorkSpace).ToList();
                foreach (var item in a)
                {
                    WorkSpaceViewModel v = new WorkSpaceViewModel();
                    v.Id = item.Id;
                    v.WsName =item.WsName;
                    v.Ismine = true;
                    wsViewmodel.Add(v);
                }
                var b = db.Wsmembers.Where(x => x.WSMem == currentUser.Id).Select(z => z.WorkSpace).ToList();
                foreach (var item in b)
                {
                    WorkSpaceViewModel v = new WorkSpaceViewModel();
                    v.Id = item.Id;
                    v.WsName = item.WsName;
                    v.Ismine = false;
                    wsViewmodel.Add(v);
                }
                return wsViewmodel;
                //var currentUser = UserManager.FindByName(user.UserName);
                //var roleresult = UserManager.AddToRole(currentUser.Id, "customer");
                //var ThenewUser = db.AspNetUsers.Find(currentUser.Id);

            }
            return new List<WorkSpaceViewModel>();

        }


        [Route("api/login")]
        public async Task<List<WorkSpaceViewModel>> loginasyncAsync(LoginViewModel model)
        {
            var signinManager = HttpContext.Current.GetOwinContext().Get<ApplicationSignInManager>();

            // This doesn't count login failures towards account lockout
            // To enable password failures to trigger account lockout, change to shouldLockout: true
            SignInStatus result =
                signinManager.PasswordSignIn(model.Email, model.Password, model.RememberMe, false);
            if (result == 0)
            {
                var user = UserManager.FindByName(model.Email);
                var temp = user.Id;
                List<WorkSpace> lws = new List<WorkSpace>();
                List<WorkSpaceViewModel> wsViewmodel = new List<WorkSpaceViewModel>();
                var a = db.WsManagers.Where(x => x.UserId == user.Id).Select(z => z.WorkSpace).ToList();
                foreach (var item in a)
                {
                    WorkSpaceViewModel v = new WorkSpaceViewModel();
                    v.Id = item.Id;
                    v.WsName = item.WsName;
                    v.Ismine = true;
                    wsViewmodel.Add(v);
                }
                var b = db.Wsmembers.Where(x => x.WSMem == user.Id).Select(z => z.WorkSpace).ToList();
                foreach (var item in b)
                {
                    WorkSpaceViewModel v = new WorkSpaceViewModel();
                    v.Id = item.Id;
                    v.WsName = item.WsName;
                    v.Ismine = false;
                    wsViewmodel.Add(v);
                }
                return await Task.FromResult(wsViewmodel);
                //return wsViewmodel;
            }
            else
            {
                return await Task.FromResult( new List<WorkSpaceViewModel>());
            }

        }


        public ApplicationUserManager UserManager
        {
            //get { return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>(); }
            get { return _userManager ?? HttpContext.Current.GetOwinContext().GetUserManager<ApplicationUserManager>(); }
            private set { _userManager = value; }
        }
        public ApplicationSignInManager SignInManager
        {
            get
            {
                return _signInManager ?? HttpContext.Current.GetOwinContext().Get<ApplicationSignInManager>();
            }
            private set
            {
                _signInManager = value;
            }
        }


        //WorkSpaces
        [HttpGet]
        [Route("api/GetWorkSpace")]
        [ResponseType(typeof(Space))]
        public IHttpActionResult GetUserWorkSpace(string id)
        {
            List<WorkSpace> lws = new List<WorkSpace>();
            List<WorkSpaceViewModel> wsViewmodel = new List<WorkSpaceViewModel>();
            var a = db.WsManagers.Where(x => x.UserId == id).Select(z => z.WorkSpace).ToList();
            foreach (var item in a)
            {
                WorkSpaceViewModel v = new WorkSpaceViewModel();
                v.Id = item.Id;
                v.WsName = item.WsName;
                v.Ismine = true;
                wsViewmodel.Add(v);
            }
            var b = db.Wsmembers.Where(x => x.WSMem == id).Select(z => z.WorkSpace).ToList();
            foreach (var item in b)
            {
                WorkSpaceViewModel v = new WorkSpaceViewModel();
                v.Id = item.Id;
                v.WsName = item.WsName;
                v.Ismine = false;
                wsViewmodel.Add(v);
            }

            return Ok(wsViewmodel);
        }


        //WorkSpaces
        [ResponseType(typeof(WorkSpace))]
        public IHttpActionResult GetWorkSpaces(string id)
        {
            var workSpace = db.Spaces.Where(x=>x.WsId==id).ToList();
            List<SpaceViewModel> lws = new List<SpaceViewModel>();
            foreach (var item in workSpace)
            {
                SpaceViewModel v = new SpaceViewModel();
                v.Id = item.Id;
                v.Name = item.SpaceName;
                lws.Add(v);
            }
            return Ok(lws);
        }


        //HomePage
        [ResponseType(typeof(WorkSpace))]
        public IHttpActionResult GetHome(string id)
        {
            var message = db.PrivateMessages.OrderByDescending(x => x.CreationDate).Take(4).ToList();
            var projects = db.Projects.Where(x => x.Tasks.Any(z=>z.DonePrecentage>0)).Take(5).ToList();
            return Ok(message);
        }




        [ResponseType(typeof(WorkSpace))]
        public IHttpActionResult PostWorkSpace(string name ,string id)
        {
            WorkSpace ws = new WorkSpace();
            ws.WsName = name;
            ws.Id = Guid.NewGuid().ToString();
           db.WorkSpaces.Add(ws);
            WsManager wsm = new WsManager();
                db.SaveChanges();

            return Ok(wsm);
        }
        // PUT: api/WorkSpaces/5


        [ResponseType(typeof(Space))]
        public IHttpActionResult PostSpace(string name, string id)
        {
            Space ws = new Space();
            ws.SpaceName = name;
            ws.WsId = id;
            ws.Id = Guid.NewGuid().ToString();
            db.Spaces.Add(ws);
            db.SaveChanges();
            return Ok();
        }
        // PUT: api/WorkSpaces/5

        [ResponseType(typeof(Project))]
        public IHttpActionResult Postproject(string name, string id)
        {
            Project ws = new Project();
            ws.Name = name;
            ws.SpaceId = id;
            ws.Id = Guid.NewGuid().ToString();
            db.Projects.Add(ws);
            db.SaveChanges();

            return Ok();
        }

        [ResponseType(typeof(Team))]
        public IHttpActionResult Postteam(string name, string id)
        {
            Team ws = new Team();
            ws.Name = name;
            ws.WsId = id;
            ws.Id = Guid.NewGuid().ToString();
            db.Teams.Add(ws);
            db.SaveChanges();

            return Ok();
        }



        public void calc(string[] args)
        {
             char[] COLON = { ':' };
             char[] SEMI_COLON = { ';' };
             char[] COMMA = { ',' };
             char[] BRACE = { ']' };
            int step = 0;

            List<Activity> i = new List<Activity>();
            Console.Write("Enter input: ");
            string s = Console.ReadLine().Replace("[", null);
            foreach (string x in s.Split(BRACE, StringSplitOptions.RemoveEmptyEntries))
            {
                string[] y = x.Split(SEMI_COLON);
                Activity n = new Activity(x.Split(COLON)[0], Int32.Parse(y[0].Split(COLON)[1]));
                n.Name = x.Split(COLON)[0];
                n.Dependencies = (y.Length > 1) ? y[1].Split(COMMA).ToList() : new List<string>();
                i.Add(n);
            }

            do
            {
                List<string> d = i.Where(x => x.Done()).Select(y => y.Name).ToList();
                foreach (Activity working in i.Where(x => x.Dependencies.Except(d).Count() == 0 && !x.Done())) working.Step(step);
                step++;
            } while (i.Count(x => !x.Done()) > 0);

            foreach (Activity a in i)
            {
                Activity next = i.OrderBy(x => x.EFinish).Where(x => x.Dependencies.Contains(a.Name)).FirstOrDefault();
                a.LFinish = (next == null) ? a.EFinish : next.EStart;
                a.LStart = a.LFinish - a.Duration;
            }

            Console.WriteLine(" name | estart | efinish | lstart | lfinish | critical");
            Console.WriteLine("------+--------+---------+--------+---------+----------");
            foreach (Activity a in i)
            {
                Console.Write(a.Name.PadLeft(5) + " |");
                Console.Write(a.EStart.ToString().PadLeft(7) + " |");
                Console.Write(a.EFinish.ToString().PadLeft(8) + " |");
                Console.Write(a.LStart.ToString().PadLeft(7) + " |");
                Console.Write(a.LFinish.ToString().PadLeft(8) + " |");
                string critical = (a.LFinish - a.EFinish == 0 && a.LStart - a.EStart == 0) ? "Y" : "N";
                Console.WriteLine(critical.PadLeft(9));
            }
            Console.WriteLine("Hit any key to exit.");
            Console.ReadKey();
        }
    }


}
