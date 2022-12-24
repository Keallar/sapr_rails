Construction.destroy_all

5.times do |i|
  construction = Construction.create!(name: "Test_#{i}")
  rand(10).times do|i|
    Rod.create!(
      place_id: i + 1,
      l: rand(10),
      a: rand(10),
      e: rand(10),
      b: rand(10),
      f: rand(10),
      q: rand(10),
      construction: construction
      )
  end
end

construction = Construction.create!(name: "Test_#{5}", left_support: true, right_support: true)
3.times do|i|
  Rod.create!(
    place_id: i + 1,
    l: 4 + i,
    a: 4 + i,
    e: 4 + i,
    b: 4 + i,
    f: 4 + i,
    q: 4 + i,
    construction: construction
  )
end

construction = Construction.create!(name: "Task_1", left_support: true, right_support: true)
3.times do |i|
  Rod.create!(
    place_id: i + 1,
    l: 4,
    a: 4,
    e: 4,
    b: 4,
    f: 4,
    q: 4,
    construction: construction
  )
end


