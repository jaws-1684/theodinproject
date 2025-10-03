class KittensController < ApplicationController
	def index
		@kittens = Kitten.all

		respond_to do |format|
        format.html 
        format.json { render :json => @kittens }
     end
	end

	def show
		@kitten = Kitten.find(params[:id])

		respond_to do |format|
        format.html 
        format.json { render :json => @kitten }
     end
	end

	def new
		@kitten = Kitten.new
	end

	def create
		@kitten = Kitten.new(kitten_params)

		@kitten.image = @kitten.get_image(@kitten.cuteness)

		if @kitten.save
			redirect_to @kitten, notice: "Kitten was succesefully saved"
		else
			flash[:error] = "There was an error creating your kitten."	
			render 'new', status: :unprocessable_entity
		end	
	end

	def edit
		@kitten = Kitten.find(params[:id])
	end
	
	def update
		@kitten = Kitten.find(params[:id])

		if @kitten.update(kitten_params)
			redirect_to @kitten, notice: "Kitten was succesefully edited."	
		else
			render 'edit', status: :unprocessable_entity
		end
	end

	def destroy
		@kitten = Kitten.find(params[:id])
		@kitten.destroy
		redirect_to root_path, status: :see_other
	end

	private

	def kitten_params
		params.expect(kitten: [:name, :age, :cuteness, :softness, :image])
	end
		
end


