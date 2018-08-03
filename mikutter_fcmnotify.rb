# -*- coding: utf-8 -*-


Plugin.create(:mikutter_fcmnotify) do

 on_favorite do |service, user, msg|
    if msg.from_me?
      data = {
       :title => "Favorited by #{user.idname}",
       :body => msg.description,
       :url => msg.uri
    }
      Plugin.call(:fcm, data)
    end
  end 

  on_mention do |service ,msg|
    msg.each do |m|
      if Time.now - m.created < 10 and !m.retweet?
        data = {
        :title => "Mentioned by #{m.user.idname}",
        :body => m.description,
        :url => m.uri
      }
       Plugin.call(:fcm, data)
      end
    end
  end

  on_retweet do |msg|
    msg.each do |m|
      if Time.now - m.created < 10
        m.retweet_source_d.next { |s|
          if s.from_me?
            data = {
            :title => "ReTweeted by #{m.user.idname}",
            :body => s.description,
            :url => s.uri
          }
           Plugin.call(:fcm, data)
          end
        }
      end
    end
  end

end