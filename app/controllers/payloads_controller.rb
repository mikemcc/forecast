class PayloadsController < ApplicationController
  before_action :set_payload, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :create]


  # GET /payloads/1/new
  def new
    @payload = Payload.new
  end

  # POST /payloads
  # POST /payloads.json
  def create
    #puts "*** payload contents ***"
    #puts params[:payload][:contents]
    uploaded_io = params[:payload][:contents]
    #puts uploaded_io.original_filename
    #puts uploaded_io.read

    csv_text = uploaded_io.read

    puts "*** look here ***"
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      rhash = row.to_hash
      puts rhash.to_s

      item_id = rhash["Item ID"].to_i
      puts "item_id = #{item_id}"
      sheet_id = rhash["Sheet ID"].to_i
      puts "sheet_id = #{sheet_id}"
      vendor_id = rhash["Vendor ID"].to_i
      puts "vendor_id = #{vendor_id}"
      vendor_name = rhash["Vendor Name"]
      puts "vendor_name = #{vendor_name}"
      signature = rhash["Signature"]
      puts "signature = #{signature}"



      sheet = @user.sheets.find(sheet_id)
      if sheet == nil
        # trying to upload a sheet that does not belong to the User
        raise Exception, "sheet does not belong to user"
      end

      item = sheet.items.find(item_id)
      if item == nil
        # this sheet does not contain this item
        raise Exception, "sheet does not contain item"
      end
      puts "item = #{item}"
      puts "item.id = #{item.id}"
      puts "item.vendor_id = #{item.vendor_id}"

      if item.vendor_id != vendor_id
        puts "class of item.vendor_id = #{item.vendor_id.class}"
        puts "class of vendor_id = #{vendor_id.class}"
        raise Exception, "item, vendor_id mismatch"
      end

      check_sig = Item.sign(@user.id, vendor_id, vendor_name)
      puts "CSV signature = #{signature}"
      puts "check_sig = #{check_sig}"
      if check_sig != signature
        raise Exception, "signature does not match"
      end

    end

    #File.open(Rails.root.join('public',
    #                          'uploads',
    #                           uploaded_io.original_filename), 'wb') do |file|
    #    file.write(uploaded_io.read)
    #  end

    flash[:notice] = "check the log file"

    redirect_to sheets_path(user_id: @user.id)

    #@payload = Payload.new(payload_params)

    #respond_to do |format|
    #  if @payload.save
    #    format.html { redirect_to @payload, notice: 'Payload was successfully created.' }
    #    format.json { render :show, status: :created, location: @payload }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @payload.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payload_params
      params.require(:payload).permit(:contents, :user_id)
    end
end
