module NameInflector

  # Prefixes with mandatory succeeding capitals, eg.
  # the O' in O'Brian is always capitalized.
  MANDPREF = ["o'"]

  # Suffixes with mandatory capitalization
<<<<<<< HEAD
  MANDSUF = ["jr.", "sr.", "esq."]
=======
  MANDSUF = ["jr.", "sr."]
>>>>>>> 38173ece4099b486d7b8009357afc9f3c0b59708

  # Prefixes with optional succeeding capitals, eg.
  # Macintyre and MacIntyre are both valid
  OPTPREF = ["mac", "mc"]

  def self.capitalize(name)
    if name.include? "-"
      name.split("-").map{ |n| capitalize_name(n) }.join("-")
    else
      capitalize_name(name)
    end
  end

  private

  def self.capitalize_name(name)
    mandpref_match = longest_matching_prefix MANDPREF, name
    mandsuf_match = longest_matching_suffix MANDSUF, name
    optpref_match = longest_matching_prefix OPTPREF, name

<<<<<<< HEAD
    if mandpref_match.present?
      postprefix = remove_prefix name, mandpref_match
      name_fix = mandpref_match.capitalize + postprefix.capitalize

    elsif optpref_match.present?
      postprefix = remove_prefix name, optpref_match
      is_first_char_uppercase?(postprefix) ? name_fix = name : name_fix = name.capitalize

    else
      name_fix = name.capitalize
=======
    if mandpref_match.present? || mandsuf_match.present? || optpref_match.present?

      if mandpref_match.present?
        postprefix = remove_prefix name, mandpref_match
        return mandpref_match.capitalize + postprefix.capitalize
      end

      if mandsuf_match.present?
        presuffix = remove_suffix name, mandsuf_match
        return presuffix.capitalize + mandsuf_match.capitalize
      end

      if optpref_match.present?
        postprefix = remove_prefix name, optpref_match
        return optpref_match.capitalize + postprefix
      end

    elsif name.include? '-'
      return name.split('-').map{|n| n.capitalize}.join('-')

    else
      return name.capitalize
>>>>>>> 38173ece4099b486d7b8009357afc9f3c0b59708
    end
    capitalize_suffix(name_fix, mandsuf_match) if mandsuf_match.present?
    return name_fix
  end

  def self.capitalize_suffix(name, suffix)
    name.sub!("#{suffix}", "#{suffix.capitalize}")
  end

  def self.is_first_char_uppercase?(string)
    ("A".."Z").cover? string.slice(0)
  end

  def self.longest_matching_prefix(prefixes, string)
    matches = prefixes.select{|p| string.downcase.start_with?(p)}
    return nil if matches.empty?
    longest = ""
    matches.each {|m| longest = m if m.length > longest.length }
    return longest
  end

  def self.longest_matching_suffix(suffixes, string)
    matches = suffixes.select{|s| string.downcase.end_with?(s)}
    return nil if matches.empty?
    longest = ""
    matches.each {|m| longest = m if m.length > longest.length }
    return longest
  end

  def self.remove_prefix(string, prefix)
    string.slice(prefix.length, string.length - prefix.length)
  end

  def self.longest_matching_suffix(suffixes, string)
    matches = suffixes.select{|s| string.downcase.end_with?(s)}
    return nil if matches.empty?
    longest = ""
    matches.each {|m| longest = m if m.length > longest.length }
    return longest
  end

  def self.remove_suffix(string, suffix)
    string.slice(0, string.length - suffix.length)
  end
end
