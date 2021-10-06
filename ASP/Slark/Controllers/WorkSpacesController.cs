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

namespace Slark.Controllers
{
    public class WorkSpacesController : ApiController
    {
        private SlarkEntities db = new SlarkEntities();

        private ApplicationSignInManager _signInManager;
        private ApplicationUserManager _userManager;
        public bool regiesterCustomerAsync(RegisterViewModel model)
        {
            var user = new ApplicationUser { UserName = model.Email, Email = model.Email };
            var result = UserManager.Create(user, model.Password);
            if (result.Succeeded)
            {
                return true;
                //var currentUser = UserManager.FindByName(user.UserName);
                //var roleresult = UserManager.AddToRole(currentUser.Id, "customer");
                //var ThenewUser = db.AspNetUsers.Find(currentUser.Id);

            }
            return false;

        }



        public async Task<string> loginasyncAsync(LoginViewModel model)
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
                return await Task.FromResult(temp);
            }
            else
            {
                return await Task.FromResult("0");
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




        // GET: api/WorkSpaces
        //public IHttpActionResult GetWorkSpaces()
        //{
        //    return db.WorkSpaces.ToList();
        //}

        // GET: api/WorkSpaces/5
        [ResponseType(typeof(WorkSpace))]
        public IHttpActionResult GetWorkSpace(string id)
        {
            WorkSpace workSpace = db.WorkSpaces.Find(id);
            if (workSpace == null)
            {
                return NotFound();
            }

            return Ok(workSpace);
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