# frozen_string_literal: true

module Constants
  SYM_REGEX = /[^\w\s]/

  STOP_WORDS = %w[
    a
    about
    actually
    also
    although
    always
    am
    an
    and
    any
    are
    as
    at
    be
    became
    become
    but
    by
    can
    could
    did
    do
    does
    each
    either
    else
    for
    from
    had
    has
    have
    hence
    how
    i
    if
    in
    is
    it
    its
    just
    may
    maybe
    me
    might
    mine
    mine
    must
    must
    my
    my
    neither
    nor
    not
    of
    oh
    ok
    to
    when
    whenever
    where
    whereas
    wherever
    whether
    which
    while
    who
    whoever
    whom
    whose
    why
    will
    with
    within
    without
    would
    yes
    yet
    you
    your
  ].freeze

  public_constant :STOP_WORDS
  public_constant :SYM_REGEX
end
