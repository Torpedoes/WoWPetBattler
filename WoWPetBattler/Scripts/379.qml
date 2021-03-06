// Poisoned - Aura
import QtQuick 2.0

import PetAction 1.0
import PetHelper 1.0
import PetStatus 1.0
import PetType 1.0

Item
{
    //Used to allow access to static functions in PetType class.
    PetType { id: petType }

    //Used to allow access to static functions in PetHelper class.
    PetHelper { id: petHelper }

    //Returns the accuracy of the pet given the move.
    function getAccuracyRating(teamIndex)
    {
        return 0;
    }

    //Returns the critical strike rating of the pet given the move.
    function getCriticalRating(teamIndex)
    {
        return 0;
    }

    //Returns the chance on hit rating if the move has any.
    function getChanceOnHitRating(teamIndex)
    {
        return 0;
    }

    //Apply the aura's effect at the start of the turn.
    function applyAuraStart(teamIndex, petIndex, auraIndex, duration)
    {
        if (petStage.GetTeam(teamIndex).GetPet(petIndex).GetAura(auraIndex).Power == 0)
            petHelper.CheckAuraPower(petStage, petStage.GetTeam(teamIndex).GetPet(petIndex).GetAura(auraIndex), (teamIndex%2)+1, 380);

        petStage.GetTeam(teamIndex).GetPet(petIndex).AddStatus(PetStatus.Poisoned);
    }

    //Applies the aura effect to the active pet.
    function applyAura(teamIndex)
    {

    }

    //Apply the aura's effect at the end of the turn.
    function applyAuraEnd(teamIndex, petIndex, auraIndex, duration)
    {
        if (Math.random() < petStage.GetTeam(teamIndex).GetPet(petIndex).AvoidanceRating)
            return;

        var scaleFactor = 0.25;
        var baseDamage = 5;
        var attackType = PetType.Beast;
        var normalDamage = Math.round(baseDamage + petStage.GetTeam(teamIndex).GetPet(petIndex).GetAura(auraIndex).Power * scaleFactor);
        var damage = Math.round((normalDamage - petStage.GetTeam(teamIndex).ActivePet.DamageOffset)
                        * petType.GetEffectiveness(attackType, petStage.GetTeam(teamIndex).ActivePet.Type)
                        * petStage.GetTeam(teamIndex).ActivePet.DefenseModifier);

        petHelper.CheckDamage(petStage, teamIndex, petIndex, 1.5*damage, false, false);
    }

    //Grants the pet any special statuses the ability has.
    function preUseAbility(teamIndex)
    {

    }

    //Applies the ability and returns the number of hits made.
    function useAbility(teamIndex, curRound, isFirst, isAvoiding,
                        isHitting, isCritting, isProcing)
    {
        return 0;
    }
}
