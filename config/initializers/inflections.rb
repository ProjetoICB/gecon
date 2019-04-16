# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )

    inflect.irregular 'tipo_de_compra', 'tipos_de_compra'
    inflect.irregular 'fonte_de_recurso','fontes_de_recurso'
    inflect.irregular 'centro_de_custo', 'centros_de_custo'
    inflect.irregular 'tipo_de_conta', 'tipos_de_conta'
    inflect.irregular 'fornecedor', 'fornecedores'
    inflect.irregular 'item_de_receita', 'itens_de_receita'
    inflect.irregular 'item_de_despesa', 'itens_de_despesa'


end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
