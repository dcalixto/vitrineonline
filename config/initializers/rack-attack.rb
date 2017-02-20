#class Rack::Attack

  ### Configure Cache ###


  # Throttle all requests by IP (60rpm)
  #
  # Key: "rack::attack:#{Time.now.to_i/:period}:req/ip:#{req.ip}"
  #
  #

  #throttle('req/ip', :limit => 300, :period => 5.minutes) do |req|
 #   req.ip # unless req.path.start_with?('/assets')
 # end

  ### Prevent Brute-Force Login Attacks ###


  # Throttle POST requests to /login by IP address
  #
  # Key: "rack::attack:#{Time.now.to_i/:period}:logins/ip:#{req.ip}"
 
  
  #throttle('logins/ip', :limit => 5, :period => 30.seconds) do |req|
   # if req.path == '/login' && req.post?
   #   req.ip
  #  end
 # end

  # Throttle POST requests to /login by email param
  # on wood!)

  
  #throttle("logins/email", :limit => 5, :period => 30.seconds) do |req|
  #  if req.path == '/login' && req.post?
     #      req.params['email'].presence
   # end
 # end

#end


