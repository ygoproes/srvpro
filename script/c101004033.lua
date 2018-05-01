--屋敷わらし
--Yashiki Warashi
--Script by nekrozar
--not fully implemented
function c101004033.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(101004033,0))
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,101004033)
	e1:SetCondition(c101004033.discon)
	e1:SetCost(c101004033.discost)
	e1:SetTarget(c101004033.distg)
	e1:SetOperation(c101004033.disop)
	c:RegisterEffect(e1)
end
function c101004033.discon(e,tp,eg,ep,ev,re,r,rp)
	local ex1,g1,gc1,dp1,dv1=Duel.GetOperationInfo(ev,CATEGORY_TOHAND)
	local ex2,g2,gc2,dp2,dv2=Duel.GetOperationInfo(ev,CATEGORY_TODECK)
--	local ex3,g3,gc3,dp3,dv3=Duel.GetOperationInfo(ev,CATEGORY_TOEXTRA)
	local ex4,g4,gc4,dp4,dv4=Duel.GetOperationInfo(ev,CATEGORY_SPECIAL_SUMMON)
	local ex5,g5,gc5,dp5,dv5=Duel.GetOperationInfo(ev,CATEGORY_REMOVE)
	return ((ex1 and (bit.band(dv1,LOCATION_GRAVE)==LOCATION_GRAVE or g1 and g1:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE)))
		or (ex2 and (bit.band(dv2,LOCATION_GRAVE)==LOCATION_GRAVE or g2 and g2:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE)))
--		or (ex3 and (bit.band(dv3,LOCATION_GRAVE)==LOCATION_GRAVE or g3 and g3:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE)))
		or (ex4 and (bit.band(dv4,LOCATION_GRAVE)==LOCATION_GRAVE or g4 and g4:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE)))
		or (ex5 and (bit.band(dv5,LOCATION_GRAVE)==LOCATION_GRAVE or g5 and g5:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE))))
		and Duel.IsChainNegatable(ev)
end
function c101004033.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c101004033.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c101004033.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) then
		if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsRelateToEffect(re) then
			Duel.SendtoGrave(eg,REASON_EFFECT)
		end
	end
end