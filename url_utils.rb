module UrlUtils

  def create_absolute_path(potential_base, relative_url)
    absolute_url = nil;
    if relative_url.match(/^\//)
      absolute_url = create_absolute_url_from_base(potential_base, relative_url)
    else
      absolute_url = potential_base+relative_url
    end
    return absolute_url
  end

  def create_absolute_url_from_base(potential_base, relative_url)
        # checks where its http or https and takes the index value
    index_of_slash = potential_base.index('://')+3
    # than takes a current url length
    index_of_first_relevant_slash = potential_base.index('/', index_of_slash)
    if index_of_first_relevant_slash != nil
      return potential_base[0, index_of_first_relevant_slash] + relative_url
    else
     return potential_base + relative_url
    end
  end

  private :create_absolute_url_from_base
end
