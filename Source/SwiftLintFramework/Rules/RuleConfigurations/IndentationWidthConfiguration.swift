public struct IndentationWidthConfiguration: RuleConfiguration, Equatable {
    public var consoleDescription: String {
        return "severity: \(severityConfiguration.consoleDescription), "
            + "indentation_width: \(indentationWidth)"
            + "include_comments: \(includeComments)"
    }

    private(set) public var severityConfiguration: SeverityConfiguration
    private(set) public var indentationWidth: Int
    private(set) public var includeComments: Bool

    public init(
        severity: ViolationSeverity,
        indentationWidth: Int,
        includeComments: Bool
    ) {
        self.severityConfiguration = SeverityConfiguration(severity)
        self.indentationWidth = indentationWidth
        self.includeComments = includeComments
    }

    public mutating func apply(configuration: Any) throws {
        guard let configurationDict = configuration as? [String: Any] else {
            throw ConfigurationError.unknownConfiguration
        }

        if let config = configurationDict["severity"] {
            try severityConfiguration.apply(configuration: config)
        }

        if let indentationWidth = configurationDict["indentation_width"] as? Int, indentationWidth >= 1 {
            self.indentationWidth = indentationWidth
        }

        if let includeComments = configurationDict["include_comments"] as? Bool {
            self.includeComments = includeComments
        }
    }
}
