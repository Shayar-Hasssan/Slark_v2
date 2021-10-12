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


        //project status 0 pending  1 inprogress  2done 

        [Route("api/register")]
        [HttpPost]
        public GenericResponseObject<LoginRegisterViewMode> regiesterCustomerAsync([FromBody] RegisterViewModels body)
        {

            RegisterViewModel model = new RegisterViewModel();
            LoginRegisterViewMode regmodemodel = new LoginRegisterViewMode();
            model.Email = body.Email;
            model.Password = body.Password;
            var user = new ApplicationUser { UserName = model.Email, Email = model.Email };
            var result = UserManager.Create(user, model.Password);
            if (result.Succeeded)
            {
                var currentUser = UserManager.FindByName(user.UserName);
                var newuser = db.AspNetUsers.Find(currentUser.Id);
                regmodemodel.Email = newuser.Email;
                regmodemodel.userid = currentUser.Id;
                regmodemodel.username = user.UserName;
                newuser.Name = body.Name;
                db.Entry(newuser).State = EntityState.Modified;
                db.SaveChanges();
                WorkSpace ws = new WorkSpace();
                ws.Id = Guid.NewGuid().ToString();
                ws.WsName = body.Name;
                db.WorkSpaces.Add(ws);
                db.SaveChanges();
                Space spa = new Space();
                spa.Id = Guid.NewGuid().ToString();
                spa.SpaceName = body.Name;
                spa.WsId = ws.Id;
                db.Spaces.Add(spa);
                db.SaveChanges();
                WsManager wsm = new WsManager();
                wsm.Id = Guid.NewGuid().ToString();
                wsm.UserId = currentUser.Id;
                wsm.WSId = ws.Id;
                db.WsManagers.Add(wsm);
                db.SaveChanges();

                List<WorkSpace> lws = new List<WorkSpace>();
                List<WorkSpaceViewModel> wsViewmodel = new List<WorkSpaceViewModel>();
                var a = db.WsManagers.Where(x => x.UserId == currentUser.Id).Select(z => z.WorkSpace).ToList();
                foreach (var item in a)
                {
                    WorkSpaceViewModel v = new WorkSpaceViewModel();
                    v.spaces = new List<SpaceViewModel>();
                    v.Id = item.Id;
                    v.WsName = item.WsName;
                    v.Ismine = true;
                    var spaces = db.Spaces.Where(x => x.WsId == v.Id);
                    foreach (var space in spaces)
                    {
                        SpaceViewModel singlespace = new SpaceViewModel();
                        singlespace.Id = space.Id;
                        singlespace.Name = space.SpaceName;
                        v.spaces.Add(singlespace);
                    }
                    wsViewmodel.Add(v);
                }
                var b = db.Wsmembers.Where(x => x.WSMem == currentUser.Id).Select(z => z.WorkSpace).ToList();
                foreach (var item in b)
                {
                    WorkSpaceViewModel v = new WorkSpaceViewModel();
                    v.spaces = new List<SpaceViewModel>();
                    v.Id = item.Id;
                    v.WsName = item.WsName;
                    v.Ismine = false;
                    var spaces = db.Spaces.Where(x => x.WsId == v.Id);
                    foreach (var space in spaces)
                    {
                        SpaceViewModel singlespace = new SpaceViewModel();
                        singlespace.Id = space.Id;
                        singlespace.Name = space.SpaceName;
                        v.spaces.Add(singlespace);
                    }
                    wsViewmodel.Add(v);
                }
                regmodemodel.WorkSpaces = wsViewmodel;
                List<LoginRegisterViewMode> Listoflogin = new List<LoginRegisterViewMode>();
                Listoflogin.Add(regmodemodel);
                GenericResponseObject<LoginRegisterViewMode> GResp1 = new GenericResponseObject<LoginRegisterViewMode>();
                GResp1.data = Listoflogin;
                GResp1.message = "Success";
                GResp1.Code = 1;
                return GResp1;
                //var currentUser = UserManager.FindByName(user.UserName);
                //var roleresult = UserManager.AddToRole(currentUser.Id, "customer");
                //var ThenewUser = db.AspNetUsers.Find(currentUser.Id);

            }
            GenericResponseObject<LoginRegisterViewMode> GResp = new GenericResponseObject<LoginRegisterViewMode>();
            GResp.data = new List<LoginRegisterViewMode>();
            GResp.message = result.Errors.ToString();
            GResp.Code = -1;
            return GResp;

        }


        [Route("api/login")]
        public async Task<GenericResponseObject<LoginRegisterViewMode>> loginasyncAsync(LoginViewModel model)
        {
            var signinManager = HttpContext.Current.GetOwinContext().Get<ApplicationSignInManager>();
            LoginRegisterViewMode regmodemodel = new LoginRegisterViewMode();

            // This doesn't count login failures towards account lockout
            // To enable password failures to trigger account lockout, change to shouldLockout: true
            SignInStatus result =
                signinManager.PasswordSignIn(model.Email, model.Password, model.RememberMe, false);
            if (result == 0)
            {

                var user = UserManager.FindByName(model.Email);
                var temp = user.Id;
                regmodemodel.Email = user.Email;
                regmodemodel.userid = user.Id;
                regmodemodel.username = user.UserName;
                List<WorkSpace> lws = new List<WorkSpace>();
                List<WorkSpaceViewModel> wsViewmodel = new List<WorkSpaceViewModel>();
                var a = db.WsManagers.Where(x => x.UserId == user.Id).Select(z => z.WorkSpace).ToList();
                foreach (var item in a)
                {
                    WorkSpaceViewModel v = new WorkSpaceViewModel();
                    v.spaces = new List<SpaceViewModel>();
                    v.Id = item.Id;
                    v.WsName = item.WsName;
                    v.Ismine = true;
                    var spaces = db.Spaces.Where(x => x.WsId == v.Id);
                    foreach (var space in spaces)
                    {
                        SpaceViewModel singlespace = new SpaceViewModel();
                        singlespace.Id = space.Id;
                        singlespace.Name = space.SpaceName;
                        v.spaces.Add(singlespace);
                    }
                    wsViewmodel.Add(v);
                }
                var b = db.Wsmembers.Where(x => x.WSMem == user.Id).Select(z => z.WorkSpace).ToList();
                foreach (var item in b)
                {
                    WorkSpaceViewModel v = new WorkSpaceViewModel();
                    v.spaces = new List<SpaceViewModel>();
                    v.Id = item.Id;
                    v.WsName = item.WsName;
                    v.Ismine = false;
                    var spaces = db.Spaces.Where(x => x.WsId == v.Id);
                    foreach (var space in spaces)
                    {
                        SpaceViewModel singlespace = new SpaceViewModel();
                        singlespace.Id = space.Id;
                        singlespace.Name = space.SpaceName;
                        v.spaces.Add(singlespace);
                    }
                    wsViewmodel.Add(v);
                }

                regmodemodel.WorkSpaces = wsViewmodel;
                List<LoginRegisterViewMode> Listoflogin = new List<LoginRegisterViewMode>();
                Listoflogin.Add(regmodemodel);
                GenericResponseObject<LoginRegisterViewMode> GResp1 = new GenericResponseObject<LoginRegisterViewMode>();
                GResp1.data = Listoflogin;
                GResp1.message = "Success";
                GResp1.Code = 1;
                return await Task.FromResult(GResp1);
                //return wsViewmodel;
            }
            else
            {
                GenericResponseObject<LoginRegisterViewMode> GResp = new GenericResponseObject<LoginRegisterViewMode>();
                GResp.data = new List<LoginRegisterViewMode>();
                GResp.message = "invalid username or password";
                GResp.Code = -1;
                return await Task.FromResult(GResp);

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
        [HttpPost]
        [Route("api/GetWorkSpace")]
        public IHttpActionResult GetUserWorkSpace(string id)
        {
            try
            {
                List<WorkSpace> lws = new List<WorkSpace>();
                List<WorkSpaceViewModel> wsViewmodel = new List<WorkSpaceViewModel>();
                var a = db.WsManagers.Where(x => x.UserId == id).Select(z => z.WorkSpace).ToList();
                foreach (var item in a)
                {
                    WorkSpaceViewModel v = new WorkSpaceViewModel();
                    v.spaces = new List<SpaceViewModel>();
                    v.Id = item.Id;
                    v.WsName = item.WsName;
                    v.Ismine = true;
                    var spaces = db.Spaces.Where(x => x.WsId == v.Id);
                    foreach (var space in spaces)
                    {
                        SpaceViewModel singlespace = new SpaceViewModel();
                        singlespace.Id = space.Id;
                        singlespace.Name = space.SpaceName;
                        v.spaces.Add(singlespace);
                    }
                    wsViewmodel.Add(v);
                }
                var b = db.Wsmembers.Where(x => x.WSMem == id).Select(z => z.WorkSpace).ToList();
                foreach (var item in b)
                {
                    WorkSpaceViewModel v = new WorkSpaceViewModel();
                    v.spaces = new List<SpaceViewModel>();
                    v.Id = item.Id;
                    v.WsName = item.WsName;
                    v.Ismine = false;
                    var spaces = db.Spaces.Where(x => x.WsId == v.Id);
                    foreach (var space in spaces)
                    {
                        SpaceViewModel singlespace = new SpaceViewModel();
                        singlespace.Id = space.Id;
                        singlespace.Name = space.SpaceName;
                        v.spaces.Add(singlespace);
                    }
                    wsViewmodel.Add(v);
                }

                GenericResponseObject<WorkSpaceViewModel> GResp = new GenericResponseObject<WorkSpaceViewModel>();
                GResp.data = wsViewmodel;
                GResp.message = "success";
                GResp.Code = 1;
                return Ok(GResp);
            }
            catch (Exception)
            {
                GenericResponseObject<WorkSpaceViewModel> GResp = new GenericResponseObject<WorkSpaceViewModel>();
                GResp.data = new List<WorkSpaceViewModel>();
                GResp.message = "error";
                GResp.Code = -1;
                return Ok(GResp);
            }

        }

        [HttpPost]
        //WorkSpaces
        [Route("api/GetSpaces")]
        [ResponseType(typeof(SpaceViewModel))]
        public IHttpActionResult GetSpaces(string id)
        {
            try
            {
                var workSpace = db.Spaces.Where(x => x.WsId == id).ToList();
                List<SpaceViewModel> lws = new List<SpaceViewModel>();
                foreach (var item in workSpace)
                {
                    SpaceViewModel v = new SpaceViewModel();
                    v.Id = item.Id;
                    v.Name = item.SpaceName;
                    lws.Add(v);
                }

                GenericResponseObject<SpaceViewModel> GResp = new GenericResponseObject<SpaceViewModel>();
                GResp.data = lws;
                GResp.message = "success";
                GResp.Code = 1;
                return Ok(GResp);
            }
            catch (Exception)
            {
                GenericResponseObject<SpaceViewModel> GResp = new GenericResponseObject<SpaceViewModel>();
                GResp.data = new List<SpaceViewModel>();
                GResp.message = "Error";
                GResp.Code = -1;
                return Ok(GResp);
            }

        }



        [HttpPost]
        [Route("api/GetHome")]
        //HomePage
        [ResponseType(typeof(HomeViewModel))]
        public IHttpActionResult GetHome(string id, string userid, string spaceid)
        {
            List<HomeViewModel> home = new List<HomeViewModel>();
            GenericResponseObject<HomeViewModel> GResp = new GenericResponseObject<HomeViewModel>();
            try
            {
                //var message = db.PrivateMessages.OrderByDescending(x => x.CreationDate).Where(z=>z.RecieverUser==userid).GroupBy(z=>z.AspNetUser)).Take(4).ToList();
                var message = from p in db.PrivateMessages
                              where p.RecieverUser == userid
                              group p by p.AspNetUser into op
                              select op.OrderByDescending(nd => nd.CreationDate).FirstOrDefault();

                var projects = db.Projects.Where(x => x.status == 1 && x.SpaceId == spaceid).Take(5).ToList();
                HomeViewModel home1 = new HomeViewModel();
                List<UserListViewModel> userlist = new List<UserListViewModel>();
                List<ProjectsViewModel> projectList = new List<ProjectsViewModel>();
                List<SpaceViewModel> workspacelist = new List<SpaceViewModel>();
                foreach (var item in message.ToList())
                {
                    UserListViewModel user = new UserListViewModel();
                    var it = db.AspNetUsers.Find(item.RecieverUser);
                    user.id = it.Id;
                    user.Email = it.Email;
                    userlist.Add(user);
                }
                foreach (var item in projects)
                {
                    ProjectsViewModel project = new ProjectsViewModel();
                    project.id = item.Id;
                    project.Name = item.Name;
                    int perc = 0;
                    if (item.Tasks.Count != 0)
                    {
                        perc = (item.Tasks.Where(x => x.IsClosed == 1).Count() * 100) / item.Tasks.Count();

                    }
                    project.Percentage = perc.ToString();
                    project.CreationDate = item.creationDate.Value.ToString("MM/dd/yyyy");
                    projectList.Add(project);
                }
                var workSpace = db.Spaces.Where(x => x.WsId == id).ToList();
                foreach (var item in workSpace)
                {
                    SpaceViewModel v = new SpaceViewModel();
                    v.Id = item.Id;
                    v.Name = item.SpaceName;
                    workspacelist.Add(v);
                }
                home1.Projects = projectList;
                home1.recentChat = userlist;
                home1.spaces = workspacelist;
                home.Add(home1);
                GResp.data = home;
                GResp.message = "success";
                GResp.Code = 1;
                return Ok(GResp);
            }
            catch (Exception e)
            {
                GResp.data = new List<HomeViewModel>();
                GResp.message = "Error";
                GResp.Code = -1;
                return Ok(GResp);
            }

        }


        [HttpPost]
        [Route("api/GetProjectList")]
        [ResponseType(typeof(ProjectsViewModel))]
        public IHttpActionResult GetProjectList(string spaceid)
        {
            GenericResponseObject<ProjectsViewModel> GResp = new GenericResponseObject<ProjectsViewModel>();
            try
            {
                List<ProjectsViewModel> projectList = new List<ProjectsViewModel>();
                var projects = db.Projects.Where(x => x.SpaceId == spaceid).ToList();
                foreach (var item in projects)
                {
                    ProjectsViewModel project = new ProjectsViewModel();
                    project.id = item.Id;
                    project.Name = item.Name;
                    int perc = 0;
                    if (item.Tasks.Count != 0)
                    {
                        perc = (item.Tasks.Where(x => x.IsClosed == 1).Count() * 100) / item.Tasks.Count();

                    }
                    project.Percentage = perc.ToString();
                    project.CreationDate = item.creationDate.Value.ToString("MM/dd/yyyy");
                    projectList.Add(project);
                }
                GResp.data = projectList;
                GResp.message = "success";
                GResp.Code = 1;
                return Ok(GResp);
            }
            catch (Exception)
            {
                GResp.data = new List<ProjectsViewModel>();
                GResp.message = "Error";
                GResp.Code = -1;
                return Ok(GResp);
            }

        }

        [HttpPost]
        [Route("api/GetTeamList")]
        [ResponseType(typeof(TeamViewModel))]
        public IHttpActionResult GetTeamList(string workspaceid)
        {
            GenericResponseObject<TeamViewModel> GResp = new GenericResponseObject<TeamViewModel>();
            try
            {
                List<TeamViewModel> teamlist = new List<TeamViewModel>();
                var teams = db.Teams.Where(x => x.WsId == workspaceid).ToList();
                foreach (var item in teams)
                {
                    TeamViewModel team = new TeamViewModel();
                    team.members = new List<MemberViewModel>();
                    team.id = item.Id;
                    team.Name = item.Name;
                    var members = item.TeamMembers.ToList();
                    foreach (var mem in members)
                    {
                        MemberViewModel teammember = new MemberViewModel();
                        teammember.id = mem.Id;
                        teammember.userid = mem.UserId;
                        teammember.Name = mem.AspNetUser.Email;
                        teammember.isTeamLeader = mem.IsTeamLeader.ToString();
                        team.members.Add(teammember);
                    }
                    teamlist.Add(team);
                }
                GResp.data = teamlist;
                GResp.message = "success";
                GResp.Code = 1;
                return Ok(GResp);
            }
            catch (Exception)
            {
                GResp.data = new List<TeamViewModel>();
                GResp.message = "Error";
                GResp.Code = -1;
                return Ok(GResp);
            }

        }

        [HttpPost]
        [Route("api/inviteusertoworkspace")]
        [ResponseType(typeof(void))]
        public IHttpActionResult inviteusertoworkspace(string workspaceid, string userid)
        {
            Wsmember wsm = new Wsmember();
            wsm.Id = Guid.NewGuid().ToString();
            wsm.WSId = workspaceid;
            wsm.WSMem = userid;
            db.Wsmembers.Add(wsm);
            db.SaveChanges();
            GenericResponseObject<messagerespViewModel> GResp = new GenericResponseObject<messagerespViewModel>();
            GResp.data = new List<messagerespViewModel>();
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
        }
        // PUT: api/WorkSpaces/5
        [HttpPost]
        [Route("api/inviteworktoteam")]
        [ResponseType(typeof(void))]
        public IHttpActionResult inviteworktoteam(string teamid, string userid, string isTML)
        {
            TeamMember tm = new TeamMember();
            tm.Id = Guid.NewGuid().ToString();
            tm.TeamId = teamid;
            tm.UserId = userid;
            tm.IsTeamLeader = Convert.ToByte(isTML);
            db.TeamMembers.Add(tm);
            db.SaveChanges();
            GenericResponseObject<messagerespViewModel> GResp = new GenericResponseObject<messagerespViewModel>();
            GResp.data = new List<messagerespViewModel>();
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
        }
        // PUT: api/WorkSpaces/5



        [ResponseType(typeof(Space))]
        [HttpPost]
        [Route("api/PostSpace")]
        public IHttpActionResult PostSpace(string wsid, string spacename)
        {
            Space space = new Space();
            space.Id = Guid.NewGuid().ToString();
            space.WsId = wsid;
            space.SpaceName = spacename;
            db.Spaces.Add(space);
            db.SaveChanges();
            GenericResponseObject<messagerespViewModel> GResp = new GenericResponseObject<messagerespViewModel>();
            GResp.data = new List<messagerespViewModel>();
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
        }
        [ResponseType(typeof(WorkSpace))]
        [HttpPost]
        [Route("api/PostworkSpace")]
        public IHttpActionResult PostworkSpace(string userid, string spacename)
        {
            WorkSpace ws = new WorkSpace();
            ws.Id = Guid.NewGuid().ToString();
            ws.WsName = spacename;
            db.WorkSpaces.Add(ws);
            db.SaveChanges();
            WsManager wsm = new WsManager();
            wsm.Id = Guid.NewGuid().ToString();
            wsm.UserId = userid;
            wsm.WSId = ws.Id;
            db.WsManagers.Add(wsm);
            db.SaveChanges();
            GenericResponseObject<messagerespViewModel> GResp = new GenericResponseObject<messagerespViewModel>();
            GResp.data = new List<messagerespViewModel>();
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
        }

        [HttpPost]
        [Route("api/PostProject")]
        public IHttpActionResult PostProject(string spaceid, string projectname, string teamid, string datee)
        {
            Project pr = new Project();

            pr.Id = Guid.NewGuid().ToString();
            pr.Name = projectname;
            pr.SpaceId = spaceid;
            pr.status = 0;
            pr.creationDate = DateTime.Parse(datee);
            db.Projects.Add(pr);
            db.SaveChanges();
            TeamProject prt = new TeamProject();
            prt.Id = Guid.NewGuid().ToString();
            prt.TeamId = teamid;
            prt.ProjectId = pr.Id;
            db.TeamProjects.Add(prt);
            db.SaveChanges();

            GenericResponseObject<messagerespViewModel> GResp = new GenericResponseObject<messagerespViewModel>();
            GResp.data = new List<messagerespViewModel>();
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
        }


        [HttpPost]
        [Route("api/PostTeam")]
        public IHttpActionResult PostTeam(string wksid, string teamname, string membid, string leadid)
        {
            Team t = new Team();
            t.Id = Guid.NewGuid().ToString();
            t.Name = teamname;
            t.WsId = wksid;
            db.Teams.Add(t);

            TeamMember t1 = new TeamMember();
            t.Id = Guid.NewGuid().ToString();
            t.Name = teamname;
            t.WsId = wksid;
            db.Teams.Add(t);


            GenericResponseObject<messagerespViewModel> GResp = new GenericResponseObject<messagerespViewModel>();
            GResp.data = new List<messagerespViewModel>();
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
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
