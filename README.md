#### Info
*Total time spent*: ~ 6 hours

*Demo url*: https://shrouded-earth-67132.herokuapp.com/
# Local setup
```
bundle install
rails db:setup
bin/dev
```
# Questionnaire
**Alex**: Should users have different roles?
**Sayinthen**: Of course, only admin should have a rights to create projects.

**Alex**: Which types of authentication should be implemented? Password-based, multi-factor, etc…
Sayinthen**: Password-based will be enough.

**Alex**: Should user to be able modify his data?
**Sayinthen**: Yes, user should be able to change his nickname.

**Alex**: Ok, lets move to projects and comments..
**Sayinthen**: Oh yeah!

**Alex**: How many projects and comments activity plan to support?
**Sayinthen**: It shouldn't be high-load solution, but pagination must to be present.

**Alex**: Who can change project status?
**Sayinthen**: Admins and moderators should be able to change project status

**Alex**: Should Comments and status changes be present on the same or separate timelines?
**Sayinthen**: Of course on the same historical timeline!

**Alex**: Do we need support dynamic statuses or you have some list of statues?
**Sayinthen**: It shouldn't be dynamic, 'created', 'approved', 'in progress;, 'completed' is enough

**Alex**: Are there any business constraints for project statuses? For example: the status can't be changed to completed from created just from inprogress state
**Sayinthen**: At the moment we can omit it

**Alex**: Do we need to support nested comments?
**Sayinthen**: More yes than no..I will be happy in case it will be done.

**Alex**: What about requests throtling? Should we prevent mass comment adding?
**Sayinthen**: Oh! it's very good idea! Maybe captcha will be enough?

**Alex**: Should we categorize our projects?
**Sayinthen**: No, it's not needed.

**Alex**: Ok, and last portion of questions..
**Alex**: Do we have some hardware requirements or budget and time limits?
**Sayinthen**: It should be aligned with our stack that we use in our other projects - Rails, PostgreSQL, Redis
Deadline of this project is 3 hours so budget is unlimited we need to hurry up!
