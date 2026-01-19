module ScoreCalculator
  def self.calculate(pillars, selections, scores)
    selected_metric_ids = selections.to_a.select { |item| item["selected"] }.map { |item| item["metric_id"] }
    score_map = scores.to_a.to_h { |item| [item["metric_id"], item["score"].to_f] }

    pillar_scores = pillars.map do |pillar|
      metrics = pillar[:metrics].select { |metric| selected_metric_ids.include?(metric[:id]) }
      if metrics.empty?
        { pillar_id: pillar[:id], pillar_name: pillar[:name], score: 0 }
      else
        weights = normalize_weights(metrics.map { |metric| metric[:weight].to_f })
        weighted_score = metrics.each_with_index.reduce(0) do |sum, (metric, index)|
          score = score_map.fetch(metric[:id], 0)
          sum + score * weights[index]
        end
        { pillar_id: pillar[:id], pillar_name: pillar[:name], score: weighted_score * 20 }
      end
    end

    selected_pillars = pillar_scores.select { |pillar| pillar[:score] > 0 }
    pillar_weights = normalize_weights(
      selected_pillars.map do |pillar|
        config = pillars.find { |item| item[:id] == pillar[:pillar_id] }
        config ? config[:weight].to_f : 1
      end
    )

    composite_score = selected_pillars.each_with_index.reduce(0) do |sum, (pillar, index)|
      sum + pillar[:score] * pillar_weights[index]
    end

    {
      composite_score: composite_score,
      pillar_scores: pillar_scores.select { |pillar| pillar[:score] > 0 },
      maturity_band: band_for_score(composite_score)
    }
  end

  def self.normalize_weights(weights)
    total = weights.sum
    weights.map { |value| total.zero? ? 0 : value / total }
  end

  def self.band_for_score(score)
    return "Leading" if score >= 80
    return "Scaling" if score >= 60
    return "Developing" if score >= 40

    "Emerging"
  end
end
