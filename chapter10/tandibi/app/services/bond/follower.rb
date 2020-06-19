class Bond::Follower < ApplicationService
  attr_reader :requester, :target_user
  private :requester, :target_user

  def initialize(requester, target_user)
    @requester = requester
    @target_user = target_user
  end

  def call
    bond = requester.bonds.build(
      friend: target_user,
      state: bond_state
    )

    bond.save!
    bond
  end

  private

    def bond_state
      case target_user.is_public?
      when true then Bond::FOLLOWING
      when false then Bond::REQUESTING
      end
    end

end
