class Mailer < ActionMailer::Base  
  def challenge_friend(challenger, friend, media)
    @challenger = challenger
    @friend = friend
    @media = media
 
    mail(to: friend.email, subject: "Slam Challenge by #{challenger.username}") 
  end
end