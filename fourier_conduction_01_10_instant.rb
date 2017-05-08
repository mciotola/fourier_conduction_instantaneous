puts "\n\n"
puts "###############################################################################"
puts "#                                                                             #"
puts "# FOURIER HEAT CONDUCTION LAW - CONSTANT FLOW             version 01.10       #"
puts "#_____________________________________________________________________________#"
puts "#                                                                             #"
puts "# Copyright 2011-2017 by Mark Ciotola; available for use under GNU license    #"
puts "# Created on 23 December 2014 or earlier. Last revised on 08 May 2017         #"
puts "#_____________________________________________________________________________#"
puts "#                                                                             #"
puts "# Description:                                                                #"
puts "# This simulation calculates the flow of energy across a thermal              #"
puts "# conductor that connects a warmer object to a cooler object.                 #"
puts "# Both reservoirs are inexhaustible.                                          #"
puts "#                                                                             #"
puts "# Website: http://www.heatsuite.com                                           #"
puts "#                                                                             #"
puts "###############################################################################"
puts "\n\n"

      ###############################################################################
      #                                                                             #
      # Developed with Ruby 1.9.2, 2.2.4                                            #
      # Takes the following parameters: temperature of reservoirs                   #
      #                                 conductor material                          #
      #                                 conductor area                              #
	  #                                 conductor length                            #
      #                                                                             #
      # Website: http://www.heatsuite.com                                           #
      # Source site: https://github.com/mciotola/fouriers_law_of_heat_conduction    #
      ###############################################################################


puts "================================== Background =================================\n\n"
  
  puts " Fourier's Law of Conduction describes the flow of thermal     "
  puts " energy through a material across a temperature difference. "
  puts " In this simulation, the temperature difference remains constant "
  puts " with time."
  puts "\n"
  puts " dQ/dt = (k A ) (d T / d L) \n"  
  puts " k = thermal conductivity of material \n"  
  puts "\n\n"
  
# INCLUDE LIBRARIES & SET-UP

  include Math
  require 'csv'
  require 'uri'
  prompt = "> "
  
  
# SET SIMULATION PARAMETERS

  material = 'copper' #'iron' 'wood'
  area = 1.0 # m
  length = 200.0

  hottemp  = 1000 # Kelvin
  coldtemp =  300 # Kelvin


# Look-up material thermal conductivity

  if material == 'iron'
    thermalconductivity = 80.0  #W/( m K)
  elsif material == 'copper'
    thermalconductivity = 400.0
  elsif material == 'wood'
    thermalconductivity = 0.08
  end


# PREPARE TO CALCULATE RESULTS

# Initialize simulation variables

  entropyhot = 0.0
  entropycold = 0.0

  tempdiff = hottemp - coldtemp
  heatenergyflow = ( (area * thermalconductivity) / length) * tempdiff

# optional output file

  puts "\n"
  puts "What is the desired name for your output file? [fourier_conduction_constant.csv]:"
  print prompt
  output_file = STDIN.gets.chomp()

  if output_file > ""
    output_file = output_file
  else
    output_file = "fourier_w_exhaust_one_rsvr.csv"
  end

# Display the parameters

  puts "================================== Parameters =================================\n\n"

  puts sprintf "  Hot temp (in K): \t\t %7.3f " , hottemp.to_s
  puts sprintf "  Cold temp (in K): \t\t %7.3f " , coldtemp.to_s

  puts sprintf "  Thermal conductivity: \t %7.3f %s" , thermalconductivity.to_s, " in Watts/meter/Kelvin"
  puts sprintf "  Area (in m^2): \t\t %7.3f " , area.to_s
  puts sprintf "  Length (in m): \t\t %7.3f " , length.to_s
  puts sprintf "  Material: \t\t\t %7s " , material
  puts "\n\n"  


# CALCULATE AND OUTPUT THE RESULTS

# Calculate simulation results

  if coldtemp < hottemp
            
      tempdiff = hottemp - coldtemp
      heatenergyflow = ( (area * thermalconductivity) / length) * tempdiff
  
      entropyflowhot = - heatenergyflow/hottemp
      entropyflowcold = heatenergyflow/coldtemp
  
      entropychange = entropyflowhot + entropyflowcold

# Simulation Banner

puts "\n\n"
puts "RESULTS: \n\n"

puts "  Rate of Thermal Energy Flow (J/s) \t\t\t" + heatenergyflow.to_s
puts "  Rate of entropy decrease in hot reservoir(J/(K s)): \t" + entropyflowhot.to_s
puts "  Rate of entropy decrease in cold reservoir(J/(K s)): \t" + entropyflowcold.to_s
puts "  Rate of change in total entropy (J/(K s)): \t\t" + entropychange.to_s

# Output variable short names

        hott = hottemp
        coldt = coldtemp
        tdiff = tempdiff
        hef = heatenergyflow
        sfhot = entropyflowhot
        sfcold = entropyflowcold
        sc = entropychange

# Write to Output File
      periodstring = hott.to_s+"\t"+coldt.to_s+"\t"+tdiff.to_s+"\t"+hef.to_s+"\t"+sfhot.to_s+"\t"+sfcold.to_s+"\t"+sc.to_s


      CSV.open(output_file, "a+") do |csv|
          csv << [hott.to_s, coldt.to_s, hef.to_s]
      end
    
    # end

  else
  
  puts "\n ERROR: cold reservoir tempurature exceeds hot reservoir temperature."
  
  end

puts "\nSimulation is completed. \n\n"


# END MATTER

# Display key and references

  puts "\n\n"

  puts "================================== Units Key ==================================\n\n"
  puts "  Abbreviation: \t\t Unit:"
  puts "\n"
  puts "       J \t\t\t Joules, a unit of energy"
  puts "       K \t\t\t Kelvin, a unit of temperature"
  puts "       m \t\t\t meters, a unit of length"
  puts "       s \t\t\t seconds, a unit of time"
  puts "\n\n"


  puts "================================== References =================================\n\n"

  puts "Georgia State University, \"Thermal Conductivity\", HyperPhysics \n"
  puts "  " + URI("http://hyperphysics.phy-astr.gsu.edu/hbase/thermo/thercond.html").to_s
  puts "  " + "last viewed on 2017 February 6."
  puts "\n"
  puts "Neville Hogan, \"Heat Transfer and the Second Law\" \n"
  puts "  " + URI("https://ocw.mit.edu/courses/mechanical-engineering/2-141-modeling-and-simulation-of-dynamic-systems-fall-2006/lecture-notes/heat_transfer.pdf").to_s
  puts "  " + "last viewed on 2017 February 6."
  puts "\n"
  puts "Daniel V. Schroeder, 2000, \"An Introduction to Thermal Physics.\""
  puts "\n\n"

# Table of thermal conductivities (Watts/meter/Kelvin)

  # Material	Thermal Conductivity
  # air				  0.026
  # wood			  0.08
  # water			  0.6
  # iron			 80
  # copper			400
