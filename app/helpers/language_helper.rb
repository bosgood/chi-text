module LanguageHelper
  def t_fire(lang)
    {
      :operation => :fire,
      :language => lang
    }
  end

  def t_police(lang)
    {
      :operation => :police,
      :language => lang
    }
  end

  def t_library(lang)
    {
      :operation => :library,
      :language => lang
    }
  end

  def t_flu(lang)
    {
      :operation => :flu,
      :language => lang
    }
  end

  def t_language(lang)
    {
      :operation => :language,
      :language => lang
    }
  end

  def t_help(lang)
    {
      :operation => :help,
      :language => lang
    }
  end

  def t_directions(lang)
    {
      :operation => :directions,
      :language => lang
    }
  end

  def t_(key)
    h = {}
    h['fire'] = t_fire('en')
    h['bombero'] = t_fire('es')
    h['bomberos'] = t_fire('es')
    h['fuego'] = t_fire('es')
    h['police'] = t_police('en')
    h['policía'] = t_police('es')
    h['policia'] = t_police('es')
    h['library'] = t_library('en')
    h['biblioteca'] = t_library('es')
    h['gripe'] = t_flu('es')
    h['flu'] = t_flu('en')
    h['shot'] = t_flu('en')
    h['help'] = t_help('en')
    h['ayuda'] = t_help('es')
    h['informacion'] = t_help('es')
    h['information'] = t_help('en')
    h['info'] = t_help('en')
    h['idioma'] = t_language('es')
    h['language'] = t_language('en')
    h['espanol'] = t_language('es')
    h['español'] = t_language('es')
    h['directions'] = t_directions('en')
    h['direcciónes'] = t_directions('es')

    h[key]
  end
end