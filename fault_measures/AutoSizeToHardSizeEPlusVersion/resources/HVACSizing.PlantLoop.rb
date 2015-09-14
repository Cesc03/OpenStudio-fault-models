
# open the class to add methods to return sizing values
class OpenStudio::Model::PlantLoop

  # Sets all auto-sizeable fields to autosize
  def autosize
    self.autosizeMaximumLoopFlowRate
    self.autocalculatePlantLoopVolume
    self.autosizeMinimumLoopFlowRate
  end

  # Takes the values calculated by the EnergyPlus sizing routines
  # and puts them into this object model in place of the autosized fields.
  # Must have previously completed a run with sql output for this to work.
  def applySizingValues

    maximum_loop_flow_rate = self.autosizedMaximumLoopFlowRate
    if maximum_loop_flow_rate.is_initialized and self.isMaximumLoopFlowRateAutosized
      self.setMaximumLoopFlowRate(maximum_loop_flow_rate.get) 
    end

    minimum_loop_flow_rate = self.autosizedMinimumLoopFlowRate
    if minimum_loop_flow_rate.is_initialized and self.isMinimumLoopFlowRateAutosized
      self.setMinimumLoopFlowRate(minimum_loop_flow_rate.get) 
    end

    plant_loop_volume = self.autocalculatedPlantLoopVolume
    if plant_loop_volume.is_initialized and self.isPlantLoopVolumeAutocalculated
      self.setPlantLoopVolume(plant_loop_volume.get) 
    end
    
  end

  # returns the autosized maximum loop flow rate as an optional double
  def autosizedMaximumLoopFlowRate

    return self.model.getAutosizedValue(self, 'Maximum Loop Flow Rate', 'm3/s')
    
  end

  # returns the autosized minimum loop flow rate as an optional double
  def autosizedMinimumLoopFlowRate

    return self.model.getAutosizedValue(self, 'Minimum Loop Flow Rate', 'm3/s')
    
  end
  
  # returns the autosized plant loop volume as an optional double
  def autocalculatedPlantLoopVolume

    return self.model.getAutosizedValue(self, 'Plant Loop Volume', 'm3')
    
  end
  
  
end
