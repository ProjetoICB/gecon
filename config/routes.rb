Rails.application.routes.draw do



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



  get 'busca' => 'lancamentos#busca', as: 'busca'
  get 'result' => 'lancamentos#result', as: 'result'

  get 'busca_conta' => 'contas#busca_conta' , as: 'busca_conta'
  get 'result_conta' => 'contas#result_conta' , as: 'result_conta'

  #desativações
  get 'desativa_conta/:id' => 'contas#desativa_conta', as: 'desativar_conta'
  get 'desativa_usuario/:id' => 'usuarios#desativa_usuario', as: 'desativar_usuario'
  get 'desativa_departamento/:id' => 'deparntamentos#desativa_departamento', as: 'desativar_departamento'
  get 'desativa_tipodecompra/:id' => 'tipos_de_compra#desativa_tipodecompra', as: 'desativa_tipodecompra'
  get 'desativa_fontederecurso/:id' => 'fontes_de_recurso#desativa_fontederecurso', as: 'desativa_fontederecurso'
  get 'desativa_centrodecusto/:id' => 'centros_de_custo#desativa_centrodecusto', as: 'desativa_centrodecusto'
  get 'desativa_grupo/:id' => 'grupos#desativa_grupo', as: 'desativa_grupo'
  get 'desativa_tipo_conta/:id' => 'tipos_de_conta#desativa_tipo_conta', as: 'desativa_tipo_conta'
  get 'desativa_fornecedor/:id' => 'fornecedores#desativa_fornecedor' , as: 'deativa_fornecedor'
  get 'deativa_item_despesa/:id' => 'itens_de_despesa#desativa_item_despesa', as: 'desativa_item_despesa'
  get 'deativa_item_receita/:id' => 'itens_de_receita#desativa_item_receita', as: 'desativa_item_receita'






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
