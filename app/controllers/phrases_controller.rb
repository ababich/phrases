class PhrasesController < ApplicationController
  SEARCH_OUTPUT_LIMIT = 5

  before_filter :require_user
  before_filter :set_phrase, :only => [:edit, :show, :destroy]
  before_filter :set_lang_text, :only => [:new, :live_search]

  def new
    conds = {:language_id => @lang, :text => @text}

    phrase = Phrase.first(:conditions => conds) ||
      Phrase.create!(conds.merge({:user => @user}))

    redirect_to edit_phrase_url(phrase)
  end


  def show
    redirect_to edit_phrase_path(@phrase)
  end

  def destroy
    @phrase.destroy

    redirect_back_or_default root_url
  end

  def live_search
    phrases = []
    language = Language.find_by_id(@lang)
    
    if language && !@text.empty?
      phrases = Phrase.all :conditions => ["language_id = ? and text like ?", @lang, "#{@text}%"],
        :limit => SEARCH_OUTPUT_LIMIT + 1
    end


    puts phrases.length > SEARCH_OUTPUT_LIMIT
    respond_to do |format|
      format.js {
        render :update do |page|
          page.replace_html 'search_variants', :partial => '/phrases/search_results',
          :locals  => {
            :phrases => phrases.first(SEARCH_OUTPUT_LIMIT),
            :more => (phrases.length > SEARCH_OUTPUT_LIMIT),
            :source => @s_params["translation_source"]}

          if @text.empty? || Phrase.exists?({:language_id => @lang, :text => @text})
            page.hide('search_add_phrase')
          else
            page.show('search_add_phrase')
          end
        end
      }
    end
  end



  private

  def set_phrase
    @phrase = Phrase.find params["id"]
    @translations = @phrase.translations
  end

  def set_lang_text
    @s_params = params["search"]
    @lang = @s_params["language"]
    @text = @s_params["phrase"]
  end

end
