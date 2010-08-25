class TranslationsController < ApplicationController
  before_filter :require_user
  before_filter :set_translation, :only => [:edit, :show, :destroy]

  def new
    s_params = params["search"]
    source_id = s_params['translation_source']

    target_id = s_params['translation_target']

    puts source_id
    puts target_id

    unless target_id
      lang = s_params["language"]
      text = s_params["phrase"]

      conds = {:language_id => lang, :text => text}

      target = Phrase.first(:conditions => conds) ||
        Phrase.create!(conds.merge({:user => @user}))
    end

    tr = Translation.create!(
      :user => @user,
      :source_id => source_id,
      :target_id => target_id || target.id
    )

    redirect_to edit_translation_url(tr)
  end


  def show
    redirect_to edit_translation_path(@translation)
  end

  def destroy
    @translation.destroy

    redirect_back_or_default root_url
  end

  private

  def set_translation
    @translation = Translation.find params["id"]
    @twin = Translation.first(:conditions =>
        {:source_id => @translation.target.id, :target_id => @translation.source.id})
  end
end
