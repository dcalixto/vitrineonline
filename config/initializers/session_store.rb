#Vitrineonline::Application.config.session_store :cookie_store, key: '_vitrineonline_session'



Vitrineonline::Application.config.session_store :redis_store, servers: { host: "localhost",
                                                                         port: 6379,
                                                                         db: 0,
                                                                         #password: "mysecret",
                                                                         namespace: "session"
                                                                       },
                                                                       expires_in: 90.minutes
