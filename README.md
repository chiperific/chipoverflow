# chip overflow
Chip __Overflow__ - Where A Developer Learns, Shares, & Build his Career

# Hello, Interviewers!
Easter eggs are fun, but is this really the time and place?

`## =====> Hello, Interviewers!`

I added a specific comment to anything I wanted to point out in my public repos.

I'm assuming you like to pay some attention to details, but don't want to read every file, so I added this breadcrumb trail for you.

# TODO
1. Header has TODO links
  - Something creative with inbox
  - Generalized searchbar

2. Left sidebar
  - attributes `.youarehere{'aria-current' => 'true'}` set dynamically by page
  - Design navigation:
    * PUBLIC
      - Questions (use as self-designed interview)
      - Tags (mirrors collectives, plus soft-skills)
      - <s>Users<s/>
      - <s>Companies<s/>
    * COLLECTIVES (use as language / framework references)
      - Ruby
      - Ruby on Rails
      - PHP
      - Wordpress
      - Javascript
      - JQuery
    * TEAMS (use as work history)
      - Michigan Natural Storage
      - Pine Rest
      - American Red Cross
      - 20 Liters
      - Mutually Human
      - GiveCamp / Code for Good

3. Author structure:
  - name [Faker::Name](https://github.com/faker-ruby/faker/blob/main/lib/faker/default/name.rb)
  - reputation (random #)
  - identicon
    -  `"https://www.gravatar.com/avatar/#{:random_number}?s=32&d=identicon&r=PG"`

3. Post structure:
  - Title (slug url?)
  - title_slug
  - body
  - tags
  - vote_count (button click incrementation)
  - view_count (page load incrementation)
  - question_id (when is an answer, self-referential)
  - rank (for page positioning, timestamp.to_i to start out with, then increased / decreased as necessary for ranking)
  - timestamps


4. Comments structure:
  - post_id
  - body
  - rank
  - timestamps

5. Sign-in modal
  - `_signin.haml`
  - w/ contact info
  - and email form (as if it were a sign-in)
  - and password form (disabled)


3. Breadcrumb md page with links to all repos

"//a[@href='/users/1880203/chiperific']"
pg.at_xpath("//a[@href='/users/1880203/chiperific']//div[2]")
