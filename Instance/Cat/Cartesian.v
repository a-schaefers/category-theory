Set Warnings "-notation-overridden".

Require Import Category.Lib.
Require Export Category.Structure.Cartesian.
Require Export Category.Construction.Product.
Require Export Category.Instance.Cat.

Generalizable All Variables.
Set Primitive Projections.
Set Universe Polymorphism.
Unset Transparent Obligations.

Program Instance Cat_Cartesian : @Cartesian Cat := {
  Prod := @Product;
  fork := fun _ _ _ F G =>
            {| fobj := fun x => (F x, G x)
             ; fmap := fun _ _ f => (fmap[F] f, fmap[G] f) |};
  exl := fun _ _ =>
            {| fobj := fst
             ; fmap := fun _ _ => fst |};
  exr := fun _ _ =>
            {| fobj := snd
             ; fmap := fun _ _ => snd |};
}.
Next Obligation. proper; apply fmap_respects; auto. Qed.
Next Obligation. split; simpl; rewrite !fmap_comp; intuition. Qed.
Next Obligation.
  proper.
  destruct X; assumption.
Qed.
Next Obligation.
  proper.
  destruct X; assumption.
Qed.
Next Obligation.
  proper.
  refine {| to   := _; from := _ |}; simpl.
  Unshelve.
  all:swap 1 3. refine {| transform := _ |}; simpl.
  all:swap 1 4. refine {| transform := _ |}; simpl.
  Unshelve.
  all:swap 1 5.
  all:swap 2 6.
  - simpl; intros.
    split.
      apply (transform[to X0]).
    apply (transform[to X1]).
  - simpl; intros.
    split.
      apply (transform[from X0]).
    apply (transform[from X1]).
  - simplify equiv; intros.
    split; simpl.
      destruct X0; simpl.
      destruct to, from; simpl in *.
      apply iso_to_from.
    destruct X1; simpl.
    destruct to, from; simpl in *.
    apply iso_to_from.
  - simpl; intros.
    split; simpl;
    apply natural_transformation.
  - simpl; intros.
    split; simpl;
    apply natural_transformation.
  - simplify equiv; intros.
    split; simpl.
      destruct X0; simpl.
      destruct to, from; simpl in *.
      apply iso_from_to.
    destruct X1; simpl.
    destruct to, from; simpl in *.
    apply iso_from_to.
Qed.
Next Obligation.
  simpl; split; intros.
  { destruct X0; simpl in *.
    split.
    { refine {| to   := _; from := _ |}; simpl.
      Unshelve.
      all:swap 1 3. refine {| transform := _ |}; simpl.
      all:swap 1 4. refine {| transform := _ |}; simpl.
      Unshelve.
      all:swap 1 5.
      all:swap 2 6.
      - apply to.
      - apply from.
      - simplify equiv in all.
        apply iso_to_from.
      - simpl; intros.
        destruct to; simpl in *.
        apply natural_transformation.
      - simpl; intros.
        destruct from; simpl in *.
        apply natural_transformation.
      - simplify equiv in all.
        apply iso_from_to.
    }
    { refine {| to   := _; from := _ |}; simpl.
      Unshelve.
      all:swap 1 3. refine {| transform := _ |}; simpl.
      all:swap 1 4. refine {| transform := _ |}; simpl.
      Unshelve.
      all:swap 1 5.
      all:swap 2 6.
      - apply to.
      - apply from.
      - simplify equiv in all.
        apply iso_to_from.
      - simpl; intros.
        destruct to; simpl in *.
        apply natural_transformation.
      - simpl; intros.
        destruct from; simpl in *.
        apply natural_transformation.
      - simplify equiv in all.
        apply iso_from_to.
    }
  }
  { destruct X0.
    destruct c, c0.
    simpl in *.
    refine {| to   := _; from := _ |}; simpl.
    Unshelve.
    all:swap 1 3. refine {| transform := _ |}; simpl.
    all:swap 1 4. refine {| transform := _ |}; simpl.
    Unshelve.
    all:swap 1 5.
    all:swap 2 6.
    - split; simpl.
        apply to.
      apply to0.
    - split; simpl.
        apply from.
      apply from0.
    - simplify equiv in all.
      split.
        apply iso_to_from.
      apply iso_to_from0.
    - simpl; intros.
      destruct to, to0; simpl in *.
      split; simpl.
        apply natural_transformation.
      apply natural_transformation0.
    - simpl; intros.
      destruct from, from0; simpl in *.
      split; simpl.
        apply natural_transformation.
      apply natural_transformation0.
    - simplify equiv in all.
      split.
        apply iso_from_to.
      apply iso_from_to0.
  }
Qed.
