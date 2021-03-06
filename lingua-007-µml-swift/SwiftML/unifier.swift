// -------------------------------------------------------------------------- //
// SwiftML                                                                    //
// -------------------------------------------------------------------------- //

enum Unifier {
  static func solve(constraints: Set<Constraint>) -> Result<Substitution, TypeError> {
    guard let constraint = constraints.first else {
      return .Success(Substitution.empty)
    }

    return constraint.solve().flatMap { headSubstitution in
      let tail = headSubstitution.applyTo(constraints: Set(constraints.dropFirst()))
      return solve(constraints: tail).map { tailSubstitution in
        headSubstitution.compose(with: tailSubstitution)
      }
    }
  }
}
