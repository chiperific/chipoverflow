# frozen_string_literal: true

Tag.create!([
  {:id=>1, :name=>"api", :score=>0},
  {:id=>2, :name=>"actioncontroller", :score=>0},
  {:id=>3, :name=>"actionmailer", :score=>0},
  {:id=>4, :name=>"actiontext", :score=>0},
  {:id=>5, :name=>"activerecord", :score=>0},
  {:id=>6, :name=>"ajax", :score=>0},
  {:id=>7, :name=>"association", :score=>0},
  {:id=>8, :name=>"authentication", :score=>0},
  {:id=>9, :name=>"capybara", :score=>0},
  {:id=>10, :name=>"coffeescript", :score=>0},
  {:id=>11, :name=>"config", :score=>0},
  {:id=>12, :name=>"css", :score=>0},
  {:id=>13, :name=>"database-design", :score=>0},
  {:id=>14, :name=>"database-schema", :score=>0},
  {:id=>15, :name=>"datatable", :score=>0},
  {:id=>16, :name=>"devise", :score=>0},
  {:id=>17, :name=>"gmail-api", :score=>0},
  {:id=>18, :name=>"google-api", :score=>0},
  {:id=>19, :name=>"html", :score=>0},
  {:id=>20, :name=>"javascript", :score=>0},
  {:id=>21, :name=>"jquery", :score=>0},
  {:id=>22, :name=>"json", :score=>0},
  {:id=>23, :name=>"postgresql", :score=>0},
  {:id=>24, :name=>"rake", :score=>0},
  {:id=>25, :name=>"redis", :score=>0},
  {:id=>26, :name=>"rspec", :score=>0},
  {:id=>27, :name=>"ruby", :score=>0},
  {:id=>28, :name=>"ruby-on-rails", :score=>0},
  {:id=>29, :name=>"sidekiq", :score=>0},
  {:id=>30, :name=>"xml", :score=>0}
])

Post.create!([
  {:id=>1, :title=>"How did Chip learn to code? I don't see a CS degree on his resume.", :body=>"<div>How can one learn about Computer Science if one does not attend an accredited university?</div>", :question_id=>nil},
  {:id=>2, :title=>nil, :body=>"<div><strong>TL;DR<br></strong></div><ul>\n<li>2009: Chip got good a Microsoft Access while working for the Red Cross <strong><em> </em></strong>\n</li>\n<li>2010: Chip discovered Microsoft Visual Basic for Applications to extend Access and Excel functionality </li>\n<li>2011: Mark introduced Chip to Ruby on Rails</li>\n<li>2012: Chip cut his teeth on an inventory app for the Red Cross</li>\n<li>2015: Chip launched his first solo web app: a time management and tracking site for grant-based work for the Refugee Education Center</li>\n</ul><div>\n<br><strong>The long story:</strong><br>While at the American Red Cross, Chip submitted a project to the first-ever Grand Rapids GiveCamp event...</div>", :question_id=>1},
  {:id=>3, :title=>"What does Chip know about server-side, front end stuff?", :body=>"<div>Ruby on Rails is good at generating vanilla HTML and JSON, but a good website requires visual appeal, intuitive interactions, and a reliably positive user experience.<br><br>How does Chip rate his own front-end abilities?</div>", :question_id=>nil},
  {:id=>4, :title=>nil, :body=>"<div>As a solo developer, Chip had to interact with the whole stack. It's great that Ruby on Rails just handles the server and data flow <a href=\"https://www.techopedia.com/definition/14261/automagically\">automagically</a>, but if the site looks terrible and is difficult to navigate even the developer won't want to use it.<br><br>In the early days of Rails 3, Chip tasked himself with writing most of his own CSS so as to better understand the concepts.<br>Rails (and Ruby even more so) seemed like it could be very mysterious \"under the hood\" and Chip wanted to take a different approach with CSS: learn the hard way instead of relying on magic methods.<br><br>Chip doesn't always choose to learn via the lower-level instead of the higher, more abstracted path. Some abstractions help by removing pain; some only delay pain:</div><ul><li>He got comfortable with jQuery before tackling Javascript</li><li>He used CoffeeScript for much longer than he probably should have</li><li>He discovered Haml and hasn't looked back (or at raw HTML if he can avoid it)</li></ul><div><br>These experiences taught him when to utilize abstraction layers and when to roll up your sleeves.<br><br>In past sites, Chip has used:</div><ul><li>Boostrap (v1.3 and up)</li><li>Material (Google's confidently named blue ribbon)</li><li>Stacks (ala StackOverflow, for this little project)</li></ul><div><br>And at the more base-level Chip is comfortable enough with client-side tools to ingest data from an API, add Javascript-based interactive elements, draw SVGs, and even make some flexboxes and grids.</div><div><br>As many can attest, however, knowing <strong>how</strong> to do art is <strong><em>not</em></strong> the same as <strong>being</strong> an artist.<br><br>Chip is more akin to Randal Monroe than Bob Ross. Somebody else better tell him where to put the happy little trees.</div>", :question_id=>3}
])

Comment.create!([
  {:post_id=>1, :body=>"<div>Don't forget about bootcamps!</div>"},
  {:post_id=>1, :body=>"<div>I have found that a Google Certificate doesn't <i>actually</i> help me get interviews. :(</div>"},
  {:post_id=>1, :body=>"<div>I'd like to see this novice explain big O notation! Ha!</div>"},
  {:post_id=>2, :body=>"<div>Wow! What an illustrious career! Chip has managed volunteers, supervised staff, even reported directly to Boards of Directors. He could be great working with clients and customers!</div>"}
])

PostsTag.create!([
  {:post_id=>1, :tag_id=>7},
  {:post_id=>1, :tag_id=>11},
  {:post_id=>1, :tag_id=>13},
  {:post_id=>1, :tag_id=>14},
  {:post_id=>1, :tag_id=>20},
  {:post_id=>1, :tag_id=>27},
  {:post_id=>3, :tag_id=>1},
  {:post_id=>3, :tag_id=>4},
  {:post_id=>3, :tag_id=>6},
  {:post_id=>3, :tag_id=>10},
  {:post_id=>3, :tag_id=>12},
  {:post_id=>3, :tag_id=>15},
  {:post_id=>3, :tag_id=>19},
  {:post_id=>3, :tag_id=>20},
  {:post_id=>3, :tag_id=>21},
  {:post_id=>3, :tag_id=>22},
  {:post_id=>3, :tag_id=>30}
])

ActiveRecord::Base.connection.tables.each do |t|
	ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
