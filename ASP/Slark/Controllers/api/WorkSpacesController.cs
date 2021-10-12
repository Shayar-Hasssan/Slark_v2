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
        [Route("api/wsmem")]
        public IHttpActionResult wsmem(string wksid)
        {
            List<MemberListViewModel> mm = new List<MemberListViewModel>();
            var members = db.Wsmembers.Where(x => x.WSId == wksid).ToList();
            foreach (var item in members)
            {
                MemberListViewModel t = new MemberListViewModel();
                t.userid = item.WSMem;
                t.Name = item.AspNetUser.Email;
                mm.Add(t);
            }
            GenericResponseObject<MemberListViewModel> GResp = new GenericResponseObject<MemberListViewModel>();
            GResp.data = mm;
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
        }

        [HttpPost]
        [Route("api/PostTeam")]
        public IHttpActionResult PostTeam(AddteamviewModel model)
        {
            Team t = new Team();
            t.Id = Guid.NewGuid().ToString();
            t.Name = model.teamname;
            t.WsId = model.wksid;
            db.Teams.Add(t);
            db.SaveChanges();

            foreach (var item in model.teamname)
            {
                TeamMember t1 = new TeamMember();
                t1.Id = Guid.NewGuid().ToString();
                t1.TeamId = t.Id;
                t1.UserId = model.wksid;
                if(t1.UserId==model.leadid)
                {
                    t1.IsTeamLeader = 0;
                }
                else
                {
                    t1.IsTeamLeader = 1;
                }
                
                db.Teams.Add(t);
                db.SaveChanges();
            }
            GenericResponseObject<messagerespViewModel> GResp = new GenericResponseObject<messagerespViewModel>();
            GResp.data = new List<messagerespViewModel>();
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
        }

        [HttpPost]
        [Route("api/allprojects")]
        public IHttpActionResult allprojects(string spid)
        {
            var projects = db.Projects.Where(x => x.SpaceId == spid).ToList();
            List<ProjectsViewModel> projectList = new List<ProjectsViewModel>();
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
            GenericResponseObject<ProjectsViewModel> GResp = new GenericResponseObject<ProjectsViewModel>();
            GResp.data = projectList;
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
        }
        [HttpPost]
        [Route("api/activeprojects")]
        public IHttpActionResult activeprojects(string spid)
        {
            var projects = db.Projects.Where(x => x.status == 1 && x.SpaceId == spid).ToList();
            List<ProjectsViewModel> projectList = new List<ProjectsViewModel>();
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
            GenericResponseObject<ProjectsViewModel> GResp = new GenericResponseObject<ProjectsViewModel>();
            GResp.data = projectList;
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
        }
        [HttpPost]
        [Route("api/completedprojects")]
        public IHttpActionResult completedprojects(string spid)
        {
            var projects = db.Projects.Where(x => x.status == 2 && x.SpaceId == spid).ToList();
            List<ProjectsViewModel> projectList = new List<ProjectsViewModel>();
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
            GenericResponseObject<ProjectsViewModel> GResp = new GenericResponseObject<ProjectsViewModel>();
            GResp.data = projectList;
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
        }

        [HttpPost]
        [Route("api/criticality")]
        public IHttpActionResult criticality(string projectid)
        {
            List<Activity> i = new List<Activity>();
            int step = 0;
            var tasks = db.Tasks.Where(x => x.ProjectId == projectid).ToList();
            foreach (var item in tasks)
            {
                var hours = (item.TaskStartingDate - item.TaskEndDate).TotalHours;
                Activity a = new Activity(item.taskname, Convert.ToInt32(hours));
                a.Name = item.taskname;
                List<string> list = new List<string>();
                var name = db.Tasks.Find(item.Parantid);
                list.Add(name.taskname);
                a.Dependencies = list;
                i.Add(a);
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
            List<crit> c = new List<crit>();
            foreach (Activity a in i)
            {
                crit  g = new crit();
                g.name=a.Name;
                g.estart = a.EStart.ToString();
                g.efinish = a.EFinish.ToString();
                g.lstart = a.LStart.ToString();
                g.lfinish = a.LFinish.ToString();
                g.critical = (a.LFinish - a.EFinish == 0 && a.LStart - a.EStart == 0) ? "Y" : "N";
                c.Add(g);
            }
            return Ok(c);
        }

        [HttpPost]
        [Route("api/projecttasks")]
        public IHttpActionResult projecttasks(string projtid)
        {
            List<ProjectsListViewModel> mm = new List<ProjectsListViewModel>();
            var members = db.Tasks.Where(x => x.ProjectId == projtid).ToList();
            foreach (var item in members)
            {
                ProjectsListViewModel t = new ProjectsListViewModel();
                t.id = item.Id;
                t.Name = item.taskname;
                mm.Add(t);
            }
            GenericResponseObject<ProjectsListViewModel> GResp = new GenericResponseObject<ProjectsListViewModel>();
            GResp.data = mm;
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
        }


        [HttpPost]
        [Route("api/projectmember")]
        public IHttpActionResult projectmember(string projtid)
        {
            List<MemberListViewModel> mm = new List<MemberListViewModel>();
            var teams = db.TeamProjects.Where(x => x.ProjectId == projtid).ToList();
            foreach (var item in teams)
            {
                var member = db.TeamMembers.Where(x => x.TeamId == item.TeamId).ToList();
                foreach (var item1 in member)
                {
                    MemberListViewModel t = new MemberListViewModel();
                    t.userid = item1.UserId;
                    t.Name = item1.AspNetUser.Email;
                    mm.Add(t);
                }
            }
          
            GenericResponseObject<MemberListViewModel> GResp = new GenericResponseObject<MemberListViewModel>();
            GResp.data = mm;
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
        }


        [HttpPost]
        [Route("api/projectdetails")]
        public IHttpActionResult projectdetails(string projtid)
        {
            List<ProjectsDetailsViewModel> mm = new List<ProjectsDetailsViewModel>();
            var teams = db.Projects.Find(projtid);
            ProjectsDetailsViewModel pro = new ProjectsDetailsViewModel();
            pro.id = teams.Id;
            pro.Name = teams.Name;
            pro.CreationDate = teams.creationDate.ToString();
            int perc = 0;
            if (teams.Tasks.Count != 0)
            {
                perc = (teams.Tasks.Where(x => x.IsClosed == 1).Count() * 100) / teams.Tasks.Count();

            }
            pro.Percentage = perc.ToString();
            List<TaskViewModel> tvm = new List<TaskViewModel>();
            var tasks = db.Tasks.Where(x => x.ProjectId == projtid).ToList();
            foreach (var item in tasks)
            {
                TaskViewModel t = new TaskViewModel();
                t.taskname = item.taskname;
                t.TaskEndDate = item.TaskEndDate;
                t.DonePrecentage = item.DonePrecentage;
                t.username = item.AspNetUser.Email;
                tvm.Add(t);
            }
            pro.tasks = new List<TaskViewModel> ();
            pro.tasks = tvm;
            mm.Add(pro);
            GenericResponseObject<ProjectsDetailsViewModel> GResp = new GenericResponseObject<ProjectsDetailsViewModel>();
            GResp.data = mm;
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
        }


        [HttpPost]
        [Route("api/PostTask")]
        [ResponseType(typeof(Task))]
        public IHttpActionResult PostTask(string projectid,string name ,string userid , string date,string prio,string dep)
        {
            Models.Task t = new Models.Task();
            t.Id = Guid.NewGuid().ToString();
            t.UserId = userid;
            t.Creationdate = DateTime.Now;
            t.Priority = int.Parse(prio);
            t.TaskDesc = "bla";
            t.taskname = name;
            t.TaskStartingDate = DateTime.Now;
            t.TaskEndDate = DateTime.Parse(date);
            t.ProjectId = projectid;
            Models.ProjectStatu st = new ProjectStatu();
            st.Id = Guid.NewGuid().ToString();
            st.Name = "onprogress";
            st.ProejctId = projectid;
            t.Status = st.Id;
            db.ProjectStatus.Add(st);
            db.SaveChanges();
            db.Tasks.Add(t);
                db.SaveChanges();
            GenericResponseObject<ProjectsDetailsViewModel> GResp = new GenericResponseObject<ProjectsDetailsViewModel>();
            GResp.data = new List<ProjectsDetailsViewModel>();
            GResp.message = "success";
            GResp.Code = 1;
            return Ok(GResp);
        }



        [HttpPost]
        [Route("api/addteamproject")]
        [ResponseType(typeof(Task))]
        public IHttpActionResult addteamproject()
        {
            TeamProject ts = new TeamProject();
            ts.Id = Guid.NewGuid().ToString();
            ts.ProjectId = "aece64ff-c4e9-490b-83f0-0769c99e4855";
            ts.TeamId = "6de3713d-8079-4793-a2ef-3a48e67a05e7";
            db.TeamProjects.Add(ts);
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
