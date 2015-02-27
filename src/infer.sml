structure Infer =
struct
  fun typeOf term =
    let
      open Unify
      val typedTerm = annotate term
      val subst = unify (constrain typedTerm)
      val termTy = TypedTerm.typeOf typedTerm
    in
      Subst.apply subst termTy
    end
end