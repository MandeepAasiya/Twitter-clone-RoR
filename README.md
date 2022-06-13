# README

This is a twitter clone using Ruby on Rails for backend and HTML, CSS for UI.
SQLITE3 is used as rdbms. This twitter clone website has following features :

* User: Sign_up, Sign_in, Sign_out // authentification features
	A user has a name, username,bio, active status, email,   profile picture.

* Conversation - Users can send each other private messages. 

* Tweet: create, read, update, delete operations.
	Tweets can be liked , replied to tweets by users.
	Image can also be attached with a tweet.

* Search: searching users by their names and usernames. 

* Follow: users can follow other users. Suggestions for
	Following other users is also given.

* Profiles: can see own and other user’s profile, tweets,
	Followers, Followings.
	Users can opt to temporarily suspend their account and
	Can also turn it back active if they wish to.

* Hashtags - User also have function to post #hashtags, and 
	@mention other users in their tweet.
	Recently posted #hashtags are also shown to all visitors. 




# Starting the website - 

* download the code and open it in terminal.
* run "bundle install"
* run "rails db:migrate"
* open http://localhost:3000/ in browser.
