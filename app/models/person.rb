class Person < ActiveRecord::Base

validates_presence_of :first_name, :last_name, :birthdate

def self.valid_birthdate(input)
    if (input.length == 8 && !input.match(/^[0-9]+[0-9]$/).nil?)
        true
    else
        false
    end
end

def self.get_birth_path_num(birthdate)
    birthdate = birthdate.chars.to_a.map(&:to_i)

    number  = birthdate[0] + birthdate[1] + birthdate[2] + birthdate[3] + birthdate[4] + birthdate[5] + birthdate[6] + birthdate[7]
    if number >= 9
        number = number.to_s.chars.map(&:to_i)
        number = number[0] + number[1]
    else
        number
    end

    if number <= 9
            birth_path_num = number
    else
            number = number.to_s.chars.to_a.map(&:to_i)
            birth_path_num = number[0] + number[1]
    end
end

def self.get_message(birth_path_num)

     message = "Your numerology number is #{birth_path_num}."
     
     case birth_path_num
        when 1        
            response =  "#{message}\nOne is the leader. The number one indicates the ability to stand alone, and is a strong vibration. Ruled by the Sun."
     
        when 2
                response =  "#{message}\nThis is the mediator and peace-lover. The number two indicates the desire for harmony. It is a gentle, considerate, and sensitive vibration. Ruled by the Moon."
     
        when 3
                response =  "#{message}\nNumber Three is a sociable, friendly, and outgoing vibration. Kind, positive, and optimistic, Three's enjoy life and have a good sense of humor. Ruled by Jupiter."
     
        when 4
                response =  "#{message}\nThis is the worker. Practical, with a love of detail, Fours are trustworthy, hard-working, and helpful. Ruled by Uranus."
     
        when 5
                response =  "#{message}\nThis is the freedom lover. The number five is an intellectual vibration. These are 'idea' people with a love of variety and the ability to adapt to most situations. Ruled by Mercury."
     
        when 6
                response =  "#{message}\nThis is the peace lover. The number six is a loving, stable, and harmonious vibration. Ruled by Venus."
     
        when  7
                response =  "#{message}\nThis is the deep thinker. The number seven is a spiritual vibration. These people are not very attached to material things, are introspective, and generally quiet. Ruled by Neptune."
     
        when 8
                response =  "#{message}\nThis is the manager. Number Eight is a strong, successful, and material vibration. Ruled by Saturn."
     
        when 9
                response =  "#{message}\nThis is the teacher. Number Nine is a tolerant, somewhat impractical, and sympathetic vibration. Ruled by Mars."
        end
    return response
end

end