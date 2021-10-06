using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using Slark.Models;

namespace Slark.Controllers
{
    public class SpacesController : ApiController
    {
        private SlarkEntities db = new SlarkEntities();

        // GET: api/Spaces
        public IQueryable<Space> GetSpaces()
        {
            return db.Spaces;
        }

        // GET: api/Spaces/5
        [ResponseType(typeof(Space))]
        public IHttpActionResult GetSpace(string id)
        {
            Space space = db.Spaces.Find(id);
            if (space == null)
            {
                return NotFound();
            }

            return Ok(space);
        }

        // PUT: api/Spaces/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutSpace(string id, Space space)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != space.Id)
            {
                return BadRequest();
            }

            db.Entry(space).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SpaceExists(id))
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

        // POST: api/Spaces
        [ResponseType(typeof(Space))]
        public IHttpActionResult PostSpace(Space space)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Spaces.Add(space);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (SpaceExists(space.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = space.Id }, space);
        }

        // DELETE: api/Spaces/5
        [ResponseType(typeof(Space))]
        public IHttpActionResult DeleteSpace(string id)
        {
            Space space = db.Spaces.Find(id);
            if (space == null)
            {
                return NotFound();
            }

            db.Spaces.Remove(space);
            db.SaveChanges();

            return Ok(space);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool SpaceExists(string id)
        {
            return db.Spaces.Count(e => e.Id == id) > 0;
        }
    }
}