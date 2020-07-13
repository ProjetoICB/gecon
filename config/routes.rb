Rails.application.routes.draw do






  resources :categorias
  resources :transferencias
  resources :lancamentos
  resources :contas
  resources :logs
  resources :usuarios
  resources :departamentos
  resources :itens_de_despesa
  resources :itens_de_receita
  resources :fornecedores
  resources :tipos_de_conta, as: :tipo_de_contas
  resources :senha_resets
  resources :grupos
  resources :centros_de_custo
  resources :tipos_de_compra
  resources :fontes_de_recurso

  get 'login' => 'session#new', as: 'login'
  post 'login' => 'session#create'
  get 'logout' => 'session#destroy', as: 'logout'
  get 'home/index'

  get 'transf_multipla' => 'transferencias#transf_multipla', as: 'transf_multipla'
  get 'gera_transf_multipla' => 'transferencias#gera_transf_multipla', as: 'gera_transf_multipla'

  get 'debito_multiplo' => 'lancamentos#debito_multiplo', as: 'debito_multiplo'
  get 'gera_debito_multiplo' => 'lancamentos#gera_debito_multiplo', as: 'gera_debito_multiplo'



  get 'busca' => 'lancamentos#busca', as: 'busca'
  get 'result' => 'lancamentos#result', as: 'result'

  get 'busca_conta' => 'contas#busca_conta' , as: 'busca_conta'
  get 'result_conta' => 'contas#result_conta' , as: 'result_conta'

  #desativações
  get 'desativa_conta/:id' => 'contas#desativa_conta', as: 'desativar_conta'
  get 'desativa_usuario/:id' => 'usuarios#desativa_usuario', as: 'desativar_usuario'
  get 'desativa_departamento/:id' => 'departamentos#desativa_departamento', as: 'desativar_departamento'
  get 'desativa_tipodecompra/:id' => 'tipos_de_compra#desativa_tipodecompra', as: 'desativa_tipodecompra'
  get 'desativa_fontederecurso/:id' => 'fontes_de_recurso#desativa_fontederecurso', as: 'desativa_fontederecurso'
  get 'desativa_centrodecusto/:id' => 'centros_de_custo#desativa_centrodecusto', as: 'desativa_centrodecusto'
  get 'desativa_grupo/:id' => 'grupos#desativa_grupo', as: 'desativa_grupo'
  get 'desativa_tipo_conta/:id' => 'tipos_de_conta#desativa_tipo_conta', as: 'desativa_tipo_conta'
  get 'desativa_fornecedor/:id' => 'fornecedores#desativa_fornecedor' , as: 'desativa_fornecedor'
  get 'desativa_item_despesa/:id' => 'itens_de_despesa#desativa_item_despesa', as: 'desativa_item_despesa'
  get 'desativa_item_receita/:id' => 'itens_de_receita#desativa_item_receita', as: 'desativa_item_receita'

  # ativações
  get 'ativa_usuario/:id' => 'usuarios#ativa_usuario', as: 'ativar_usuario'
  get 'ativa_centrodecusto/:id' => 'centros_de_custo#ativa_centrodecusto', as: 'ativa_centrodecusto'
  get 'ativa_conta/:id' => 'contas#ativa_conta', as: 'ativar_conta'
  get 'ativa_departamento/:id' => 'departamentos#ativa_departamento', as: 'ativar_departamento'
  get 'ativa_fontederecurso/:id' => 'fontes_de_recurso#ativa_fontederecurso', as: 'ativa_fontederecurso'
  get 'ativa_fornecedor/:id' => 'fornecedores#ativa_fornecedor' , as: 'ativa_fornecedor'
  get 'ativa_grupo/:id' => 'grupos#ativa_grupo', as: 'ativa_grupo'
  get 'ativa_item_despesa/:id' => 'itens_de_despesa#ativa_item_despesa', as: 'ativa_item_despesa'
  get 'ativa_item_receita/:id' => 'itens_de_receita#ativa_item_receita', as: 'ativa_item_receita'
  get 'ativa_tipodecompra/:id' => 'tipos_de_compra#ativa_tipodecompra', as: 'ativa_tipodecompra'
  get 'ativa_tipo_conta/:id' => 'tipos_de_conta#ativa_tipo_conta', as: 'ativa_tipo_conta'



  #relatórios
  get 'por_conta' => 'relatorios#por_conta', as: 'por_conta'
  get 'relat_por_conta' => 'relatorios#relat_por_conta', as: 'relat_por_conta'
  get 'por_lanc' => 'relatorios#por_lanc' , as: 'por_lanc'
  get 'relat_por_lanc' => 'relatorios#relat_por_lanc', as: 'relat_por_lanc'
  get 'gastos_por_idd' => 'relatorios#gastos_por_idd', as: 'gastos_por_idd'
  get 'relat_gastos_por_idd' => 'relatorios#relat_gastos_por_idd' , as: 'relat_gastos_por_idd'





  # relatorios de usuarios
  get 'plano_de_contas' => 'rel_usuarios#plano_de_contas', as: 'plano_de_contas'
  get 'resumo' => 'rel_usuarios#resumo', as: 'resumo'
  get 'detalhamento' => 'rel_usuarios#detalhamento', as: 'detalhamento'
  get 'result_detalhamento' => 'rel_usuarios#result_detalhamento', as: 'result_detalhamento'
  get 'rel_itens_de_despesa' => 'rel_usuarios#itens_de_despesa', as: 'rel_itens_de_despesa'
  get 'result_idd' => 'rel_usuarios#result_idd', as: 'result_idd'
  get 'balancete' => 'rel_usuarios#balancete', as: 'balancete'
  get 'res_balancete' => 'rel_usuarios#res_balancete', as: 'res_balancete'
  get 'resumo_icb' => 'rel_usuarios#resumo_icb', as: 'resumo_icb'








  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'home#index'
  root 'session#new'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
