Set Warnings "-notation-overridden".

Require Import Category.Lib.
Require Export Category.Theory.Functor.
Require Export Category.Instance.Sets.
Require Export Category.Instance.Nat.

Generalizable All Variables.
Set Primitive Projections.
Set Universe Polymorphism.
Unset Transparent Obligations.
Set Implicit Arguments.

Section FunctorEquiv.

Context `{C : Category}.
Context `{D : Category}.

Global Program Instance fobj_respects `{F : C ⟶ D} {A : C} :
  CMorphisms.Proper (cequiv ===> cequiv) (@fobj C D F).
Next Obligation.
  proper.
  destruct F, X; simpl.
  refine {| to   := fmap x y to
          ; from := fmap y x from |}.
    rewrite <- fmap_comp, iso_to_from; cat.
  rewrite <- fmap_comp, iso_from_to; cat.
Qed.

Global Program Instance fobj_csetoid `{F : C ⟶ Sets} {A : C} : CSetoid (F A).

(* The Identity Functor *)

Global Program Instance Identity : C ⟶ C := {
  fobj := fun X => X;
  fmap := fun _ _ f => f
}.

End FunctorEquiv.

Arguments Identity {C} /.

(* Horizontal composition of functors. *)

Program Definition functor_comp
        `{C : Category} `{D : Category} `{E : Category}
        (F : D ⟶ E) (G : C ⟶ D) : C ⟶ E := {|
  fobj := fun x => fobj (fobj x);
  fmap := fun _ _ f => fmap (fmap f)
|}.
Next Obligation.
  proper.
  rewrite X0; reflexivity.
Qed.
Next Obligation.
  intros; rewrite !fmap_comp; reflexivity.
Qed.

Hint Unfold functor_comp.

Infix "○" := functor_comp (at level 30, right associativity) : category_scope.

(* Cat is the category of all small categories:

    objects               Categories
    arrows                Functors
    arrow equivalence     Natural Isomorphisms
    identity              Identity Functor
    composition           Horizontal composition of Functors *)

Program Instance Cat : Category := {
  ob      := Category;
  hom     := @Functor;
  homset  := fun _ _ => {| cequiv := fun F G => F ≅[Nat] G |};
  id      := @Identity;
  compose := @functor_comp
}.
Next Obligation.
  equivalence.
  transitivity y; auto.
Qed.
Next Obligation.
  proper.
  refine {| to := _; from := _ |}; simpl.
  Unshelve.
  all:swap 1 3. refine {| transform := _ |}; simpl.
  all:swap 1 4. refine {| transform := _ |}; simpl.
  Unshelve.
  all:swap 1 5.
  all:swap 2 6.
  - simpl; intros.
    apply (transform[to X0] (y0 X2) ∘ fmap (transform[to X1] X2)).
  - simpl; intros.
    apply (transform[from X0] (x0 X2) ∘ fmap (transform[from X1] X2)).
  - simplify equiv; intros; simplify equiv.
    destruct X0 as [to0 from0 iso_to_from0 ?].
    destruct X1 as [to1 from1 iso_to_from1 ?].
    simpl in *.
    simplify equiv in iso_to_from0.
    simplify equiv in iso_to_from1.
    rewrite <- natural_transformation.
    rewrite <- !comp_assoc.
    rewrite (comp_assoc (transform[to0] _)).
    rewrite iso_to_from0; cat.
    rewrite <- fmap_comp.
    rewrite iso_to_from1; cat.
  - simplify equiv; intros; simplify equiv.
    rewrite <- !comp_assoc.
    rewrite <- fmap_comp.
    rewrite <- !natural_transformation.
    rewrite !fmap_comp.
    rewrite comp_assoc.
    reflexivity.
  - simplify equiv; intros; simplify equiv.
    rewrite <- !comp_assoc.
    rewrite <- fmap_comp.
    rewrite <- !natural_transformation.
    rewrite !fmap_comp.
    rewrite comp_assoc.
    reflexivity.
  - simplify equiv; intros; simplify equiv.
    destruct X0 as [to0 from0 ? iso_from_to0 ?].
    destruct X1 as [to1 from1 ? iso_from_to1 ?].
    simpl in *.
    simplify equiv in iso_from_to0.
    simplify equiv in iso_from_to1.
    rewrite <- natural_transformation.
    rewrite <- !comp_assoc.
    rewrite (comp_assoc (transform[from0] _)).
    rewrite iso_from_to0; cat.
    rewrite <- fmap_comp.
    rewrite iso_from_to1; cat.
Qed.
Next Obligation.
  simplify equiv.
  refine {| to := _; from := _ |}; simpl.
  Unshelve.
  all:swap 1 3. refine {| transform := _ |}; simpl.
  all:swap 1 4. refine {| transform := _ |}; simpl.
  Unshelve.
  all:swap 1 5.
  all:swap 2 6.
    simpl; intros.
    exact (fmap id).
  simpl; intros.
  exact (fmap id).
  all:simplify equiv; intros; simplify equiv; cat.
Qed.
Next Obligation.
  simplify equiv.
  refine {| to := _; from := _ |}; simpl.
  Unshelve.
  all:swap 1 3. refine {| transform := _ |}; simpl.
  all:swap 1 4. refine {| transform := _ |}; simpl.
  Unshelve.
  all:swap 1 5.
  all:swap 2 6.
    simpl; intros.
    exact (fmap id).
  simpl; intros.
  exact (fmap id).
  all:simplify equiv; intros; simplify equiv; cat.
Qed.
Next Obligation.
  simplify equiv.
  refine {| to := _; from := _ |}; simpl.
  Unshelve.
  all:swap 1 3. refine {| transform := _ |}; simpl.
  all:swap 1 4. refine {| transform := _ |}; simpl.
  Unshelve.
  all:swap 1 5.
  all:swap 2 6.
    simpl; intros.
    exact (fmap id).
  simpl; intros.
  exact (fmap id).
  all:simplify equiv; intros; simplify equiv; cat.
Qed.
