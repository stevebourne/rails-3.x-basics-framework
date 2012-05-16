class User < ActiveRecord::Base

  include Clearance::User

 
  has_many :authentications, :dependent => :destroy
  
  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      u.first_name = auth_hash["info"]["first_name"]
      u.last_name = auth_hash["info"]["last_name"]
      u.friendly_name = auth_hash["info"]["name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.authentications<<(authentication)
    end
  end


  # obscure permalink
  before_save :generate_permalink
 
  # enable lookup by permalink, for URL construction
  def to_param
    self.permalink
  end

  def generate_permalink
    if !self.permalink 
      self.permalink = Digest::SHA1.hexdigest(Time.now.to_s << rand(10000).to_s).force_encoding('UTF-8')
      # force_encoding added per http://stackoverflow.com/questions/7437944/sqlite3-varchar-matching-with-like-but-not
    end
  end

  
  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end
  
  
  def password_optional?
    true
  end
  
end
