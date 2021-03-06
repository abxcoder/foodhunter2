class Api::V1::Search2Controller < ApiController
    before_action :authorized

    def cari
        # cari = pencarian[:cari]
        @kategori= Kategori.where('name LIKE ?', "%#{pencarian[:cari]}")
        @kategori.count > 0 ? @food = Food.where(kategori_id: @kategori[0].id) : @food = 0



        if @menu != 0 

            @food = Food.where( kategori_id: @kategori[0].id)

            if @food 
                @rest = @food[0].id
                @resto = Restoran.where(id: @rest)
            else
                @resto = "blank"
            end

            render json: { result: @kategori, food: @food, keterangan: "masih dalam tahap pegembangan" }, status: :ok

        else

            render json: { result: "data yang anda cari tidak ditemukan" }, status: :ok
            
        end

    end

    private

    def pencarian
      params.require(:search2).permit(:cari )
    end
end
