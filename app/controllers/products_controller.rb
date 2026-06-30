class ProductsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    @products = current_creator.products.order(created_at: :desc)
    render inertia: "Products/Index", props: { products: @products.map { |p| serialize(p) } }
  end

  def new
    render inertia: "Products/Form", props: { product: nil }
  end

  def create
    @product = current_creator.products.build(product_params)
    if @product.save
      redirect_to products_path, notice: "Product created"
    else
      redirect_to new_product_path, alert: @product.errors.full_messages.join(", ")
    end
  end

  def show
    @product = current_creator.products.find(params[:id])
    render inertia: "Products/Show", props: { product: serialize(@product) }
  end

  def edit
    @product = current_creator.products.find(params[:id])
    render inertia: "Products/Form", props: { product: serialize(@product) }
  end

  def update
    @product = current_creator.products.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path, notice: "Product updated"
    else
      redirect_to edit_product_path(@product), alert: @product.errors.full_messages.join(", ")
    end
  end

  def destroy
    @product = current_creator.products.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: "Product deleted"
  end

  private

  def product_params
    params.permit(:name, :description, :price_cents)
  end

  def serialize(product)
    {
      id: product.id,
      name: product.name,
      description: product.description,
      price_cents: product.price_cents,
      created_at: product.created_at.iso8601
    }
  end

  def require_login
    redirect_to login_url unless session[:creator_id]
  end
end