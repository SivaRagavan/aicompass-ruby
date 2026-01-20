module BenchmarkData
  DEFAULT_LABELS = [ "Not yet", "Ad-hoc", "Basic", "Defined", "Advanced", "Leading" ].freeze

  QUALIFY_QUESTIONS = [
    {
      id: "ai-maturity",
      prompt: "Rate from Not yet to Leading: how would you describe your AI adoption stage?",
      helper: "This helps prioritize internal adoption and data readiness questions.",
      options: [
        {
          value: "exploring",
          label: "Exploring / pilots",
          recommended_pillars: %w[internal-adoption data-readiness executive-alignment]
        },
        {
          value: "scaling",
          label: "Scaling across teams",
          recommended_pillars: %w[internal-adoption talent governance-risk]
        },
        {
          value: "optimized",
          label: "Optimizing & monetizing",
          recommended_pillars: %w[ai-value product-strategy governance-risk]
        }
      ]
    },
    {
      id: "data-sensitivity",
      prompt: "Rate from Not yet to Leading: how sensitive is the data your teams use with AI?",
      helper: "Higher sensitivity increases governance and shadow AI importance.",
      options: [
        {
          value: "low",
          label: "Mostly public or low-risk data",
          recommended_pillars: %w[internal-adoption]
        },
        {
          value: "mixed",
          label: "Mix of internal and regulated data",
          recommended_pillars: %w[governance-risk shadow-ai]
        },
        {
          value: "high",
          label: "Highly regulated or proprietary",
          recommended_pillars: %w[governance-risk shadow-ai data-readiness]
        }
      ]
    },
    {
      id: "product-ai",
      prompt: "Rate from Not yet to Leading: is AI part of your customer-facing product roadmap?",
      helper: "Determines whether product strategy and revenue impact apply.",
      options: [
        {
          value: "not-yet",
          label: "Not yet",
          recommended_pillars: %w[internal-adoption]
        },
        {
          value: "planned",
          label: "Planned in the next 12 months",
          recommended_pillars: %w[product-strategy data-readiness]
        },
        {
          value: "live",
          label: "Live in production",
          recommended_pillars: %w[product-strategy ai-value governance-risk]
        }
      ]
    },
    {
      id: "workforce",
      prompt: "Rate from Not yet to Leading: what best describes your AI talent posture?",
      helper: "Used to focus on AI talent and leadership alignment.",
      options: [
        {
          value: "limited",
          label: "Limited in-house talent",
          recommended_pillars: %w[talent executive-alignment]
        },
        {
          value: "growing",
          label: "Growing a core team",
          recommended_pillars: %w[talent internal-adoption]
        },
        {
          value: "established",
          label: "Established AI teams",
          recommended_pillars: %w[talent ai-value]
        }
      ]
    }
  ].freeze

  PILLARS = [
    {
      id: "internal-adoption",
      name: "Internal Adoption",
      description: "How broadly AI tools are used across teams and workflows.",
      weight: 1,
      metrics: [
        {
          id: "adoption-coverage",
          name: "Workflow Coverage",
          description: "How widely AI is embedded in core workflows.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "coverage-1", prompt: "Rate from Not yet to Leading: how many core workflows use AI assistance?" },
            { id: "coverage-2", prompt: "Rate from Not yet to Leading: how many teams rely on AI for daily work?" },
            { id: "coverage-3", prompt: "Rate from Not yet to Leading: how standardized are AI-enabled workflows?" }
          ]
        },
        {
          id: "adoption-depth",
          name: "Depth of Use",
          description: "How advanced AI usage is within teams.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "depth-1", prompt: "Rate from Not yet to Leading: how advanced are AI use cases in production?" },
            { id: "depth-2", prompt: "Rate from Not yet to Leading: how integrated is AI into decision-making?" },
            {
              id: "depth-3",
              prompt: "Rate from Not yet to Leading: how often are AI outputs trusted without manual workarounds?"
            }
          ]
        },
        {
          id: "enablement",
          name: "Enablement Programs",
          description: "Training, enablement, and adoption support.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "enablement-1", prompt: "Rate from Not yet to Leading: how formalized is AI training across roles?" },
            { id: "enablement-2", prompt: "Rate from Not yet to Leading: how well-supported are internal AI champions?" },
            { id: "enablement-3", prompt: "Rate from Not yet to Leading: how accessible are AI playbooks and guidelines?" }
          ]
        }
      ]
    },
    {
      id: "shadow-ai",
      name: "Shadow AI",
      description: "Visibility and control over unsanctioned AI usage.",
      weight: 1,
      metrics: [
        {
          id: "visibility",
          name: "Tool Visibility",
          description: "Visibility into AI tools and usage.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "visibility-1", prompt: "Rate from Not yet to Leading: how well do you track AI tool usage?" },
            { id: "visibility-2", prompt: "Rate from Not yet to Leading: how complete is your inventory of AI vendors?" },
            { id: "visibility-3", prompt: "Rate from Not yet to Leading: how frequently is usage data reviewed?" }
          ]
        },
        {
          id: "policy-enforcement",
          name: "Policy Enforcement",
          description: "Ability to enforce AI usage policies.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "policy-1", prompt: "Rate from Not yet to Leading: how clearly are AI policies communicated?" },
            { id: "policy-2", prompt: "Rate from Not yet to Leading: how consistently are AI policies enforced?" },
            { id: "policy-3", prompt: "Rate from Not yet to Leading: how effective are guardrails for approved tools?" }
          ]
        },
        {
          id: "risk-mitigation",
          name: "Risk Mitigation",
          description: "Controls to reduce data leakage from shadow AI.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "risk-1", prompt: "Rate from Not yet to Leading: how strong are controls to prevent data leakage?" },
            { id: "risk-2", prompt: "Rate from Not yet to Leading: how well are high-risk prompts detected?" },
            { id: "risk-3", prompt: "Rate from Not yet to Leading: how quickly are shadow AI incidents handled?" }
          ]
        }
      ]
    },
    {
      id: "talent",
      name: "AI Talent",
      description: "Skills, hiring, and capability building.",
      weight: 1,
      metrics: [
        {
          id: "skill-coverage",
          name: "Skill Coverage",
          description: "Breadth of AI skills across the workforce.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "skill-1", prompt: "Rate from Not yet to Leading: how many roles have defined AI skill baselines?" },
            { id: "skill-2", prompt: "Rate from Not yet to Leading: how quickly can teams learn new AI tools?" },
            { id: "skill-3", prompt: "Rate from Not yet to Leading: how embedded are AI skills in hiring criteria?" }
          ]
        },
        {
          id: "specialist-depth",
          name: "Specialist Depth",
          description: "Availability of AI/ML specialists.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "specialist-1", prompt: "Rate from Not yet to Leading: how deep is the AI/ML specialist bench?" },
            { id: "specialist-2", prompt: "Rate from Not yet to Leading: how well-staffed are AI platform teams?" },
            { id: "specialist-3", prompt: "Rate from Not yet to Leading: how sustainable is AI hiring pipeline?" }
          ]
        },
        {
          id: "career-paths",
          name: "Career Paths",
          description: "Clear AI roles, growth paths, and incentives.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "career-1", prompt: "Rate from Not yet to Leading: how clear are AI career paths and progression?" },
            { id: "career-2", prompt: "Rate from Not yet to Leading: how competitive are AI compensation bands?" },
            { id: "career-3", prompt: "Rate from Not yet to Leading: how strong are retention programs for AI talent?" }
          ]
        }
      ]
    },
    {
      id: "executive-alignment",
      name: "Executive Alignment",
      description: "Leadership sponsorship, governance, and funding.",
      weight: 1,
      metrics: [
        {
          id: "leadership-sponsorship",
          name: "Leadership Sponsorship",
          description: "Executive ownership and advocacy of AI.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "leadership-1", prompt: "Rate from Not yet to Leading: how visible is executive sponsorship of AI?" },
            { id: "leadership-2", prompt: "Rate from Not yet to Leading: how aligned are leaders on AI priorities?" },
            { id: "leadership-3", prompt: "Rate from Not yet to Leading: how consistent is executive communication on AI?" }
          ]
        },
        {
          id: "portfolio-prioritization",
          name: "Portfolio Prioritization",
          description: "How AI initiatives are prioritized and funded.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "portfolio-1", prompt: "Rate from Not yet to Leading: how disciplined is AI investment prioritization?" },
            { id: "portfolio-2", prompt: "Rate from Not yet to Leading: how clear are AI business cases?" },
            { id: "portfolio-3", prompt: "Rate from Not yet to Leading: how consistently are AI initiatives funded?" }
          ]
        },
        {
          id: "governance-model",
          name: "Governance Model",
          description: "Decision-making and accountability structure.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "governance-1", prompt: "Rate from Not yet to Leading: how clear are AI governance roles?" },
            { id: "governance-2", prompt: "Rate from Not yet to Leading: how effective is AI decision-making cadence?" },
            { id: "governance-3", prompt: "Rate from Not yet to Leading: how strong is accountability for AI outcomes?" }
          ]
        }
      ]
    },
    {
      id: "data-readiness",
      name: "Data Readiness",
      description: "Data quality, access, and infrastructure.",
      weight: 1,
      metrics: [
        {
          id: "data-quality",
          name: "Data Quality",
          description: "Completeness, accuracy, and consistency.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "data-quality-1", prompt: "Rate from Not yet to Leading: how reliable is data quality for AI use cases?" },
            { id: "data-quality-2", prompt: "Rate from Not yet to Leading: how complete are key datasets?" },
            { id: "data-quality-3", prompt: "Rate from Not yet to Leading: how automated are data quality checks?" }
          ]
        },
        {
          id: "data-access",
          name: "Data Access",
          description: "Availability and discoverability of data.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "data-access-1", prompt: "Rate from Not yet to Leading: how easy is it to access data for AI work?" },
            { id: "data-access-2", prompt: "Rate from Not yet to Leading: how mature is data governance for sharing?" },
            { id: "data-access-3", prompt: "Rate from Not yet to Leading: how self-serve is data discovery?" }
          ]
        },
        {
          id: "mlops",
          name: "AI Infrastructure",
          description: "Pipelines, MLOps, and tooling readiness.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "mlops-1", prompt: "Rate from Not yet to Leading: how production-ready are AI pipelines?" },
            { id: "mlops-2", prompt: "Rate from Not yet to Leading: how standardized are model deployment practices?" },
            { id: "mlops-3", prompt: "Rate from Not yet to Leading: how strong is monitoring of AI systems?" }
          ]
        }
      ]
    },
    {
      id: "product-strategy",
      name: "AI Product Strategy",
      description: "AI in product roadmap and differentiation.",
      weight: 1,
      metrics: [
        {
          id: "roadmap",
          name: "AI Roadmap",
          description: "Clear product strategy for AI capabilities.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "roadmap-1", prompt: "Rate from Not yet to Leading: how clear is the AI product roadmap?" },
            { id: "roadmap-2", prompt: "Rate from Not yet to Leading: how well does AI align with product strategy?" },
            { id: "roadmap-3", prompt: "Rate from Not yet to Leading: how frequently is the AI roadmap reviewed?" }
          ]
        },
        {
          id: "differentiation",
          name: "Differentiation",
          description: "AI-driven competitive advantage.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "diff-1", prompt: "Rate from Not yet to Leading: how differentiated are AI features in market?" },
            { id: "diff-2", prompt: "Rate from Not yet to Leading: how defensible are AI capabilities?" },
            { id: "diff-3", prompt: "Rate from Not yet to Leading: how measurable is AI-driven advantage?" }
          ]
        },
        {
          id: "customer-feedback",
          name: "Customer Feedback Loop",
          description: "Feedback and iteration on AI features.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "feedback-1", prompt: "Rate from Not yet to Leading: how systematic is AI feedback collection?" },
            {
              id: "feedback-2",
              prompt: "Rate from Not yet to Leading: how quickly are AI insights turned into improvements?"
            },
            { id: "feedback-3", prompt: "Rate from Not yet to Leading: how well are AI outcomes communicated to customers?" }
          ]
        }
      ]
    },
    {
      id: "ai-value",
      name: "AI Revenue & Value",
      description: "Monetization and measurable business impact.",
      weight: 1,
      metrics: [
        {
          id: "value-realization",
          name: "Value Realization",
          description: "Quantified benefits and ROI tracking.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "value-1", prompt: "Rate from Not yet to Leading: how well is AI value tracked and reported?" },
            { id: "value-2", prompt: "Rate from Not yet to Leading: how repeatable is AI value measurement?" },
            { id: "value-3", prompt: "Rate from Not yet to Leading: how strong are ROI baselines for AI?" }
          ]
        },
        {
          id: "revenue-contribution",
          name: "Revenue Contribution",
          description: "Revenue directly tied to AI features.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "revenue-1", prompt: "Rate from Not yet to Leading: how meaningful is AI-driven revenue today?" },
            { id: "revenue-2", prompt: "Rate from Not yet to Leading: how clear are AI monetization paths?" },
            { id: "revenue-3", prompt: "Rate from Not yet to Leading: how consistent is AI revenue forecasting?" }
          ]
        },
        {
          id: "productivity-gains",
          name: "Productivity Gains",
          description: "Measured operational efficiency improvements.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "prod-1", prompt: "Rate from Not yet to Leading: how measured are AI productivity gains?" },
            { id: "prod-2", prompt: "Rate from Not yet to Leading: how widely realized are efficiency improvements?" },
            { id: "prod-3", prompt: "Rate from Not yet to Leading: how sustained are AI efficiency gains over time?" }
          ]
        }
      ]
    },
    {
      id: "governance-risk",
      name: "Governance & Risk",
      description: "Responsible AI, safety, and compliance.",
      weight: 1,
      metrics: [
        {
          id: "responsible-ai",
          name: "Responsible AI",
          description: "Ethics, bias mitigation, and transparency.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "resp-1", prompt: "Rate from Not yet to Leading: how well are bias risks assessed in AI systems?" },
            { id: "resp-2", prompt: "Rate from Not yet to Leading: how transparent are AI models and decisions?" },
            { id: "resp-3", prompt: "Rate from Not yet to Leading: how robust are responsible AI reviews?" }
          ]
        },
        {
          id: "security",
          name: "Security Controls",
          description: "Security testing, access controls, and monitoring.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "sec-1", prompt: "Rate from Not yet to Leading: how mature are AI security controls?" },
            { id: "sec-2", prompt: "Rate from Not yet to Leading: how continuous is AI threat monitoring?" },
            { id: "sec-3", prompt: "Rate from Not yet to Leading: how tested are AI incident response plans?" }
          ]
        },
        {
          id: "compliance",
          name: "Compliance Readiness",
          description: "Regulatory policies and auditability.",
          weight: 1,
          labels: DEFAULT_LABELS,
          questions: [
            { id: "comp-1", prompt: "Rate from Not yet to Leading: how prepared are you for AI regulations?" },
            { id: "comp-2", prompt: "Rate from Not yet to Leading: how audit-ready are AI systems?" },
            { id: "comp-3", prompt: "Rate from Not yet to Leading: how routinely are compliance gaps reviewed?" }
          ]
        }
      ]
    }
  ].freeze

  def self.pillars
    PILLARS
  end

  def self.qualify_questions
    QUALIFY_QUESTIONS
  end

  def self.pillar_by_id(pillar_id)
    PILLARS.find { |pillar| pillar[:id] == pillar_id }
  end

  def self.metric_by_id(pillar_id, metric_id)
    pillar = pillar_by_id(pillar_id)
    return nil unless pillar

    pillar[:metrics].find { |metric| metric[:id] == metric_id }
  end

  def self.metrics_for_pillar(pillar_id)
    pillar_by_id(pillar_id)&.fetch(:metrics, []) || []
  end

  def self.selected_metrics(selections)
    selected_metric_ids = selections.to_a.select { |item| item["selected"] }.map { |item| item["metric_id"] }

    PILLARS.flat_map do |pillar|
      pillar[:metrics].filter_map do |metric|
        next unless selected_metric_ids.include?(metric[:id])

        { pillar: pillar, metric: metric }
      end
    end
  end

  def self.build_selections(selected_pillar_ids)
    PILLARS.flat_map do |pillar|
      pillar[:metrics].map do |metric|
        {
          "pillar_id" => pillar[:id],
          "metric_id" => metric[:id],
          "selected" => selected_pillar_ids.include?(pillar[:id])
        }
      end
    end
  end
end
