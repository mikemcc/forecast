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

    labels_to_keys = {}
    labels_to_keys["Item ID"] = "item_id"
    labels_to_keys["Sheet ID"] = "sheet_id"
    labels_to_keys["Vendor ID"] = "vendor_id"
    labels_to_keys["Vendor Name"] = "vendor_name"
    labels_to_keys["Jan"] = "january"
    labels_to_keys["Feb"] = "february"
    labels_to_keys["Mar"] = "march"
    labels_to_keys["Apr"] = "april"
    labels_to_keys["May"] = "may"
    labels_to_keys["Jun"] = "june"
    labels_to_keys["Jul"] = "july"
    labels_to_keys["Aug"] = "august"
    labels_to_keys["Sep"] = "september"
    labels_to_keys["Oct"] = "october"
    labels_to_keys["Nov"] = "november"
    labels_to_keys["Dec"] = "december"
    labels_to_keys["Signature"] = "signature"

    # there are columns in the spreadsheet that are useful in
    # CSV form, but that we don't need to update when we're
    # operating on the item
    skip_keys   = ["signature","vendor_name","item_id", "vendor_id", "sheet_id"]

    # we automatically convert all CSV data to integer, unless
    # the column is specifically listed as a string value
    string_keys = ["signature", "vendor_name"]

    # make sure that we don't try to operate on multiple 'sheet'
    # objects with a single CSV file
    previous_sheet_id = nil

    uploaded_io = params[:payload][:contents]
    csv_text = uploaded_io.read
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      rhash = row.to_hash
      puts "*** the following are straight from the CSV file ***"
      item_id = rhash["Item ID"].to_i
      puts "item_id = #{item_id}"
      sheet_id = rhash["Sheet ID"].to_i
      puts "sheet_id = #{sheet_id}"
      vendor_id = rhash["Vendor ID"].to_i
      puts "vendor_id = #{vendor_id}"
      vendor_name = rhash["Vendor Name"]
      puts "vendor_name = #{vendor_name}"
      csv_signature = rhash["Signature"]
      puts "csv_signature = #{csv_signature}"

      sheet = @user.sheets.find(sheet_id)
      if sheet == nil
        # trying to upload a sheet that does not belong to the User
        raise Exception, "sheet does not belong to user"
      end

      # are we trying to change items from multiple sheets?
      if previous_sheet_id != nil && previous_sheet_id != sheet_id
        raise Exception, "Cannot mix and match sheets!"
      else
        previous_sheet_id = sheet_id
      end

      item = sheet.items.find(item_id)
      if item == nil
        # this sheet does not contain this item
        raise Exception, "sheet does not contain item"
      end
      puts "*** this is the item looked up via ActiveRecord ***"
      puts "item = #{item}"
      puts "item.id = #{item.id}"
      puts "item.vendor_id = #{item.vendor_id}"
      puts "item.signature = #{item.signature}"

      if item.vendor_id != vendor_id
        puts "class of item.vendor_id = #{item.vendor_id.class}"
        puts "class of vendor_id = #{vendor_id.class}"
        raise Exception, "item, vendor_id mismatch"
      end

      # compute the signature based on information provided by
      # the CSV
      check_signature = Item.check_signature(item_id, vendor_id, vendor_name)
      puts "check_signature = #{check_signature}"
      if check_signature != csv_signature
        raise Exception, "signature does not match"
      end

      row_attributes = {}
      # loop through keys of csv
      rhash.keys.each do | rkey |
        puts "lookging for database table equivalent of #{rkey}"
        # get database key
        dkey = labels_to_keys["#{rkey}"]
        # there are columns on the spreadsheet that we don't need to update
        if skip_keys.include?(dkey)
          next
        end
        if string_keys.include?(dkey)
          row_attributes[dkey.to_sym] = rhash[rkey]
        else
          row_attributes[dkey.to_sym] = rhash[rkey].to_i
        end
      end

      # now try to upate item using attributes hash
      item.update(row_attributes)
      flash[:notice] = "successes: "
      flash[:alert] = "failures: "
      if item.valid?
        item.save
        flash[:notice] = flash[:notice] + "Updated item #{item.id}. "
      else
        flash[:alert] = flash[:alert] + "Failed to save item ##{item.id} - proposed changes were invalid. "
      end
    end

    redirect_to sheet_path(previous_sheet_id)

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
