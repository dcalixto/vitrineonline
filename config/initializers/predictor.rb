Predictor.redis = Redis.new(:url => ENV["PREDICTOR_REDIS"])
Predictor.processing_technique(:lua)
Predictor.redis_prefix 'predictor:vitrineonline'
