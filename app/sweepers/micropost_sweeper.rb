class MicropostSweeper < ActionController::Caching::Sweeper
  observe Micropost

  def expire_cached_content(micropost)
    if fragment_exist?([micropost.user, :user_info])
      expire_fragment([micropost.user, :user_info])
    end
    # it does not work with memcached
    # expire_fragment( /#{Regexp.quote(micropost.user.cache_key)}/ )

  end

  alias_method :after_create, :expire_cached_content
  alias_method :after_destroy, :expire_cached_content
end