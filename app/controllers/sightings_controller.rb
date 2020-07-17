class SightingsController < ApplicationController
    def index
        sightings = Sighting.all
        render json: sightings, include: [:bird, :location]
        # render json: sightings.to_json(include: [:bird, :location]) #explicit
    end
    
    def show
        sighting = Sighting.find_by(id: params[:id])
        # render json: sighting

        if sighting 
            # connecting data
            # render json: { id: sighting.id, bird: sighting.bird, location: sighting.location }
            # render json: sighting, include: [:bird, :location]
            # render json: sighting.to_json(include: [:bird, :location]) #explicit 
            # render json: sighting, include: [:bird, :location], except: [:updated_at] #removes some attributes from nested data
            render json: sighting.to_json(:include => {
                :bird => {:only => [:name, :species]},
                :location => {:only => [:latitude, :longitude]}
            }, :except => [:updated_at]) #while this produces nice results, it complicates the render line too much for such minimal results
        else
            render json: { message: 'No sighting found with that id' }
        end
    end
end
