# The file contains functions to pass arguments from OpenStudio inputs to the
# measure script. They are used to avoid the function arguments to be too long.

# 11/18/2017 Lighting Setback Error measure developed based on HVAC Setback Error measure
# codes within ######## are modified parts

module OsLib_FDD

  require_relative 'global_const'

  def pass_zone(model, allchoices)
    # This function returns the zone handle and zone display name in
    # the OpenStudio model so that they can be used as part of the
    # arguments in the measure script

    # make a choice argument for model objects
    zone_handles = OpenStudio::StringVector.new
    zone_display_names = OpenStudio::StringVector.new

    # putting model object and names into hash
    zone_args = model.getThermalZones
    zone_args_hash = {}
    zone_args.each do |zone_arg|
      zone_args_hash[zone_arg.name.to_s] = zone_arg
    end

    # looping through sorted hash of model objects
    zone_args_hash.sort.map do |key, value|
      zone_handles << value.handle.to_s
      zone_display_names << key
    end
    zone_handles << ''
    zone_display_names << allchoices

    return zone_handles, zone_display_names
  end

  def obtainzone(strname, model, runner, user_arguments)
    # This function helps to obtain the zone information from user arguments.
    # It returns the ThermalZone OpenStudio object of the chosen zone

    thermalzone = runner.getStringArgumentValue(strname, user_arguments)
    if thermalzone.eql?($allzonechoices)
      return model.getThermalZones
    else
      thermalzones = []
      model.getThermalZones.each do |zone|
        next unless thermalzone.to_s == zone.name.to_s
        thermalzones << zone
        break
      end
      return thermalzones
    end
  end
  
  def obtainlight(zone, model, runner, user_arguments)
    # This function helps to obtain the light information from user arguments.
    # It returns the Lights OpenStudio object of the chosen zone
	array = []
	spaces = model.getSpaces
	
    if zone.eql?($allzonechoices)
	  spaces.each do |space|
		array << space.lights
      end
      return array
    else
	  spaces.each do |space|
        next unless space.name.to_s == zone.to_s
        array << space.lights
        break
      end
      return array
    end
  end
  
  ##########################################################
  ##########################################################
  def obtainpeople(zone, model, runner, user_arguments)
    # This function helps to obtain the light information from user arguments.
    # It returns the Lights OpenStudio object of the chosen zone
	array = []
	spaces = model.getSpaces
	
    if zone.eql?($allzonechoices)
	  spaces.each do |space|
		array << space.people
      end
      return array
    else
	  spaces.each do |space|
        next unless space.name.to_s == zone.to_s
        array << space.people
        break
      end
      return array
    end
	runner.registerInfo("People = #{array}")
  end
  ##########################################################
  ##########################################################

end