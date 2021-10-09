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
        [ResponseType(typeof(void))]
        public IHttpActionResult PutWorkSpace(string id, WorkSpace workSpace)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != workSpace.Id)
            {
                return BadRequest();
            }

            db.Entry(workSpace).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!WorkSpaceExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/WorkSpaces
        [ResponseType(typeof(WorkSpace))]
        public IHttpActionResult PostWorkSpace(WorkSpace workSpace)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.WorkSpaces.Add(workSpace);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (WorkSpaceExists(workSpace.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = workSpace.Id }, workSpace);
        }

        // DELETE: api/WorkSpaces/5
        [ResponseType(typeof(WorkSpace))]
        public IHttpActionResult DeleteWorkSpace(string id)
        {
            WorkSpace workSpace = db.WorkSpaces.Find(id);
            if (workSpace == null)
            {
                return NotFound();
            }

            db.WorkSpaces.Remove(workSpace);
            db.SaveChanges();

            return Ok(workSpace);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool WorkSpaceExists(string id)
        {
            return db.WorkSpaces.Count(e => e.Id == id) > 0;
        }
    }
}