class MicropostSweeper < ActionController::Caching::Sweeper
  observe Micropost

  def expire_cached_content(micropost)
=begin
    if fragment_exist?([micropost.user, :user_info])
      expire_fragment([micropost.user, :user_info])
    end
=end
    # it does not work with memcached
    # expire_fragment( /#{Regexp.quote(micropost.user.cache_key)}/ )
   unless Rails.application.config.cache_store[0] != :redis_store
      `redis-cli KEYS "#{Rails.application.config.cache_store[1][:namespace]}:views/#{micropost.user.cache_key}*" | xargs redis-cli DEL`
    end
  end

  alias_method :after_create, :expire_cached_content
  alias_method :after_destroy, :expire_cached_content
end