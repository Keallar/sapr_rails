require 'matrix'

class ConstructionService
  attr_reader :l, :a, :e, :f, :q, :construction, :u, :n, :s

  def initialize(construction)
    @construction = construction
    @l = []
    construction.rods.each { |r| @l << r.l.to_f unless r.l.nil? }
    @a = []
    construction.rods.each { |r| @a << r.a.to_f unless r.a.nil? }
    @e = []
    construction.rods.each { |r| @e << r.e.to_f unless r.e.nil? }
    @f = []
    construction.rods.each { |r| @f << r.f.to_f unless r.f.nil? }
    @q = []
    construction.rods.each { |r| @q << r.q.to_f unless r.q.nil? }
    @u = []
    @n = []
    @s = []
  end

  def perform
    rods = construction.rods
    rods_count = rods.size
    support_left = construction.left_support
    support_right = construction.right_support

    b = b_calculate(rods_count, support_left, support_right)
    a = a_calculate(rods_count, support_left, support_right)
    a_matrix = Matrix[*a]
    a_inverse_matrix = a_matrix.inv
    deltas = Array.new(rods_count + 1, 0.0)
    deltas.size.times do |i|
      deltas.size.times do |j|
        deltas[i] += a_inverse_matrix[i, j] * b[j]
      end
    end

    rods.each do |rod|
      rod.update!(delta_0: deltas[rod.place_id - 1], delta_l: deltas[rod.place_id])
    end

    rods.each do |r|
      u_values = u_calculate(r)
      print u_values, "\n"
      r.update!(u: u_values)
    end

    rods.each do |r|
      n_values = n_calculate(r)
      print n_values, "\n"
      r.update!(n: n_values)
    end

    rods.each do |r|
      s_values = s_calculate(r)
      print s_values, "\n"
      r.update!(s: s_values)
    end
  end

  private

  def a_calculate(rods_count, left_limit, right_limit)
    a_a = Array.new(rods_count + 1) { Array.new(rods_count + 1, 0.0) }

    (rods_count + 1).times do |i|
      if i == rods_count
        a_a[rods_count][rods_count] = e[rods_count - 1] * a[rods_count - 1] / l[rods_count - 1]
      else
        k = ((e[i] * a[i]) / l[i]).to_f
        a_a[i][i] += k
        a_a[i + 1][i + 1] += k
        a_a[i + 1][i] -= k
        a_a[i][i + 1] -= k
      end
    end

    if left_limit
      puts a_a[0][0]
      a_a[0][0] = 1.0
      a_a[0][1] = 0.0
      a_a[1][0] = 0.0
    end

    if right_limit
      a_a[rods_count][rods_count] = 1.0
      a_a[rods_count][rods_count - 1] = 0.0
      a_a[rods_count - 1][rods_count] = 0.0
    end

    a_a
  end

  def b_calculate(rods_count, left_limit, right_limit)
    b = Array.new(rods_count + 1)
    f.size.times do |i|
      if i.zero?
        b[i] = f[0] + (q[0] * l[0]) / 2.0
        b[i + 1] = (q[0] * l[0]) / 2.0
      elsif b == rods_count
        b[i] = f[i]
        b[i] += (q[i - 1] * l[i - 1]) / 2.0
      else
        b[i] += f[i] + (q[i] * l[i]) / 2.0
        b[i + 1] = (q[i] * l[i]) / 2.0
      end
    end

    b[0] = 0.0 if left_limit
    b[rods_count] = 0.0 if right_limit

    b
  end

  def u_calculate(rod)
    u = Array.new(11, 0.0)
    xs = Array.new(11, 0.0)
    xs.size.times do |i|
      xs[i] = (i * rod.l / 10).to_f
    end
    u.size.times do |i|
      u[i] = ((1 - (xs[i] / rod.l)) * rod.delta_0 + (xs[i] / rod.l) * rod.delta_l +
        ((rod.q * rod.l * rod.l ) / (2 * rod.e * rod.a)) * (xs[i] / rod.l) * (1 - (xs[i] / rod.l))).to_f
    end
    u
  end

  def n_calculate(rod)
    n = Array.new(11, 0.0)
    xs = Array.new(11, 0.0)
    xs.size.times do |i|
      xs[i] = (i * rod.l / 10).to_f
    end
    n.size.times do |i|
      n[i] = (((rod.e * rod.a) / rod.l) * (rod.delta_l - rod.delta_0) +
        ((rod.q * rod.l) / 2) * (1 - 2 * (xs[i] / rod.l))).to_f
    end
    n
  end

  def s_calculate(rod)
    s = Array.new(11, 0.0)
    xs = Array.new(11, 0.0)
    xs.size.times do |i|
      xs[i] = (i * rod.l / 10).to_f
    end
    s.size.times do |i|
      s[i] = (rod.n[i] / rod.a).to_f
    end
    s
  end
end